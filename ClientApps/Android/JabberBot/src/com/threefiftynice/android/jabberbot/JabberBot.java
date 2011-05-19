package com.threefiftynice.android.jabberbot;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.os.PowerManager;
import android.os.PowerManager.WakeLock;
import android.util.Log;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.view.Window;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.SeekBar.OnSeekBarChangeListener;
import android.widget.TextView;
import android.widget.Toast;

import com.MobileAnarchy.Android.Widgets.Joystick.DualJoystickView;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickClickedListener;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickMovedListener;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickView;

public class JabberBot extends Activity {
	protected static final String TAG = JabberBot.class.getSimpleName();
	private static final boolean D = true;

    // Intent request codes
    private static final int REQUEST_CONNECT_DEVICE_SECURE = 1;
    private static final int REQUEST_CONNECT_DEVICE_INSECURE = 2;
    private static final int REQUEST_ENABLE_BT = 3;
	
    // Message types sent from the BluetoothChatService Handler
    public static final int MESSAGE_STATE_CHANGE = 1;
    public static final int MESSAGE_READ = 2;
    public static final int MESSAGE_WRITE = 3;
    public static final int MESSAGE_DEVICE_NAME = 4;
    public static final int MESSAGE_TOAST = 5;

    // Key names received from the BluetoothChatService Handler
    public static final String DEVICE_NAME = "device_name";
    public static final String TOAST = "toast";

	private static final float MOTOR_UI_RESOLUTION = 1.0f;
	private static final long MOTOR_UI_DELAY = 0;
	private static final int MOTOR_MIN_DRIVE = 20;

	private static final float SERVO_UI_RESOLUTION = 1.0f;
	private static final long SERVO_UI_DELAY = 0;

    private final Handler mHandler = new Handler() {
		@Override
        public void handleMessage(Message msg) {
            switch (msg.what) {
            case MESSAGE_STATE_CHANGE:
                if(D) Log.i(TAG, "MESSAGE_STATE_CHANGE: " + msg.arg1);
                switch (msg.arg1) {
                case BluetoothClient.STATE_NONE:
                	mTitle.setText("Not connected");
                    break;
                case BluetoothClient.STATE_CONNECTING:
                	mTitle.setText("Connecting...");
                    break;
                case BluetoothClient.STATE_CONNECTED:
                    mTitle.setText("Connected to: " + mConnectedDeviceName);
                    onDeviceConnected();
                    break;
                case BluetoothClient.STATE_FAILED:
                	mTitle.setText("Connection lost :-(");
                    break;
                }
                break;
            case MESSAGE_WRITE:
            	if (D) {
                    byte[] writeBuf = (byte[]) msg.obj;
                    String writeMessage = new String(writeBuf);
                    Log.d(TAG, "TX: \"" + writeMessage + "\"");
            	}
                break;
            case MESSAGE_READ:
            	if (D) {
                	try {
                		byte[] readBuf = (byte[]) msg.obj;
        				String readMessage = new String(readBuf, 0, msg.arg1);
                        Log.d(TAG, "RX: \"" + readMessage + "\"");
                	}
                	catch ( Exception ex) {
                		Log.e(TAG, ex.getMessage(), ex);
                	}
            	}
                break;
            case MESSAGE_DEVICE_NAME:
                // save the connected device's name
                mConnectedDeviceName = msg.getData().getString(DEVICE_NAME);
                Toast.makeText(getApplicationContext(), "Connected to " + mConnectedDeviceName, Toast.LENGTH_SHORT).show();
                break;
            case MESSAGE_TOAST:
                Toast.makeText(getApplicationContext(), msg.getData().getString(TOAST), Toast.LENGTH_SHORT).show();
                break;
            }
        }
    };

	private ServoController servoController;
	private MotorController motorController;
	private JoystickClickedListener driveClickedListener;
	private JoystickClickedListener lookClickedListener;

	private BluetoothClient mBTClient;
	private JabberClient jabberClient;
	private TextView mTitle;
    private String mConnectedDeviceName;

	private BluetoothAdapter mBluetoothAdapter;

	private DualJoystickView vJoystick;
	private SeekBar vVol;
	private Prefs prefs;
	private VolumeControl vCtrl;
	private WakeLock wl;

	private void onDeviceConnected() {
		prefs.setLastConnectedDevice(mBTClient.getConnectedDevice().getAddress());
		jabberClient.sendReset();
		
		mHandler.postDelayed(new Runnable() {
			@Override
			public void run() {
				jabberClient.playSound(1, 1, 1);
				mHandler.postDelayed(new Runnable() {
					@Override
					public void run() {
						jabberClient.playSound(1, 255, 2);
					}
				}, 5000);
			}
		}, 100);
		
		vVol.setProgress(prefs.getLastVolume());
		vCtrl.setVolume(prefs.getLastVolume());
	}

    @Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

		prefs = new Prefs(this);
		
        // Set up the window layout
        requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.dualstick);
        getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.custom_title);

        jabberClient = new JabberClient(this);
        
        // Set up the custom title
        mTitle = (TextView) findViewById(R.id.title_left_text);
        mTitle.setText(R.string.app_name);
        mTitle = (TextView) findViewById(R.id.title_right_text);

        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter != null) {
            // Initialize the BluetoothChatService to perform bluetooth connections
        	mBTClient = new BluetoothClient(this, mHandler);
        }
        else {
          Toast.makeText(this, "Bluetooth is not available", Toast.LENGTH_LONG).show();
          finish();
          return;
        }
        
        PowerManager pm = (PowerManager) getSystemService(POWER_SERVICE);
        wl = pm.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK, TAG);
        wl.acquire();
        
		setupUI();			
	}

    @Override
    protected void onPause() {
    	super.onPause();
        wl.release();
    }

    @Override
    public void onDestroy() {
        super.onDestroy();
        
        jabberClient.sendReset();
        if (mBTClient != null) mBTClient.stop();
        
        if(D) Log.e(TAG, "--- ON DESTROY ---");
    }

    @Override
    public void onStart() {
        super.onStart();
        if(D) Log.e(TAG, "++ ON START ++");

        // If BT is not on, request that it be enabled.
        // setupChat() will then be called during onActivityResult
        if ( mBluetoothAdapter != null ) {
            if (!mBluetoothAdapter.isEnabled()) {
                Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
                startActivityForResult(enableIntent, REQUEST_ENABLE_BT);
            // Otherwise, setup the chat session
            } else {
            	if ( !reconnectLastDevice() )
            		startConnectDeviceSecure();
            }
        }
    }

    private boolean reconnectLastDevice() {
        // Get the device MAC address
    	String address = prefs.getLastConnectedDevice();
    	
        if (address != null && mBluetoothAdapter != null) {
            // Get the BLuetoothDevice object
            BluetoothDevice device = mBluetoothAdapter.getRemoteDevice(address);
            // Attempt to connect to the device
            mBTClient.connect(device, true);
            return true;
        }
        
        return false;
    }
    
    private void connectDevice(Intent data, boolean secure) {
        if (mBluetoothAdapter != null) {
            // Get the device MAC address
            String address = data.getExtras().getString(DeviceListActivity.EXTRA_DEVICE_ADDRESS);
            // Get the BLuetoothDevice object
            BluetoothDevice device = mBluetoothAdapter.getRemoteDevice(address);
            // Attempt to connect to the device
            mBTClient.connect(device, secure);
        }
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(D) Log.d(TAG, "onActivityResult " + resultCode);
        switch (requestCode) {
        case REQUEST_CONNECT_DEVICE_SECURE:
            // When DeviceListActivity returns with a device to connect
            if (resultCode == Activity.RESULT_OK)
                connectDevice(data, true);
            break;
        case REQUEST_CONNECT_DEVICE_INSECURE:
            // When DeviceListActivity returns with a device to connect
            if (resultCode == Activity.RESULT_OK)
                connectDevice(data, false);
            break;
        case REQUEST_ENABLE_BT:
            // When the request to enable Bluetooth returns
            if (resultCode == Activity.RESULT_OK) {
                // Bluetooth is now enabled, so set up a chat session
                startConnectDeviceSecure();
            } else {
                // User did not enable Bluetooth or an error occured
                Log.e(TAG, "BT not enabled");
                Toast.makeText(this, "BT not enabled, exiting", Toast.LENGTH_SHORT).show();
                finish();
            }
        }
    }

    public void sendMessage(byte[]send) {
    	sendMessage(send, 0, send.length);
    }
    
    public void sendMessage(byte[]send, int len) {
    	sendMessage(send, 0, len);
    }
    
    /**
     * Sends a message.
     * @param message  A string of text to send.
     */
    private void sendMessage(byte[] send, int offset, int length) {
    	if ( mBTClient != null ) {
            // Check that we're actually connected before trying anything
            if (mBTClient.getState() != BluetoothClient.STATE_CONNECTED) {
                //Toast.makeText(this, "Not connected", Toast.LENGTH_SHORT).show();
                return;
            }

            // Check that there's actually something to send
            if (send != null && send.length > 0) {
                mBTClient.write(send);
            }
    	}
    }

	private void setupUI() {
		vVol = (SeekBar)findViewById(R.id.vVol);
		vCtrl = new VolumeControl();
		vVol.setOnSeekBarChangeListener(vCtrl);
		
		Button b1 = (Button)findViewById(R.id.b1);
		b1.setOnClickListener(new OnClickListener() {
			byte[] z = new byte[] { 'r', (byte)1 };
			@Override
			public void onClick(View v) {
				sendMessage(z);
			}
		});
		
		Button b2 = (Button)findViewById(R.id.b2);
		b2.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				jabberClient.playSound(2, 1, 8);
			}
		});
		
		Button b3 = (Button)findViewById(R.id.b3);
		b3.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				jabberClient.playSound(2, 1, 9);
			}
		});
		
		Button b4 = (Button)findViewById(R.id.b4);
		b4.setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				jabberClient.playSound(2, 1, 11);
			}
		});
		
		servoController = new ServoController();
		motorController = new MotorController();

		vJoystick = (DualJoystickView)findViewById(R.id.vJoystick);
		vJoystick.setMovementConstraint(JoystickView.CONSTRAIN_CIRCLE);
		vJoystick.setOnJostickMovedListener(motorController, servoController);
		vJoystick.setYAxisInverted(false, false);
		vJoystick.setAutoReturnToCenter(true, false);
		vJoystick.setMovementRange(motorController.getMovementRange(), servoController.getMovementRange());
		vJoystick.setMoveResolution(MOTOR_UI_RESOLUTION, SERVO_UI_RESOLUTION);
		vJoystick.setUserCoordinateSystem(JoystickView.COORDINATE_DIFFERENTIAL, JoystickView.COORDINATE_CARTESIAN);

		driveClickedListener = new JoystickClickedListener() {
			@Override
			public void OnReleased() {
			}
			
			@Override
			public void OnClicked() {
			}
		};
		
		lookClickedListener = new JoystickClickedListener() {
			@Override
			public void OnReleased() {
			}
			
			@Override
			public void OnClicked() {
			}
		};
		vJoystick.setOnJostickClickedListener(driveClickedListener, lookClickedListener);
	}
	
	@Override
    public boolean onCreateOptionsMenu(Menu menu) {
        MenuInflater inflater = getMenuInflater();
        inflater.inflate(R.menu.option_menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
        case R.id.menu_connect:
            startConnectDeviceSecure();
            return true;
        case R.id.menu_music_on:
        	jabberClient.playSound(3, 255, 1);
            return true;
        case R.id.menu_music_off:
        	jabberClient.stopSound(3);
            return true;
        case R.id.menu_reset:
        	jabberClient.sendReset();
        	mHandler.postDelayed(new Runnable() {
        		@Override
        		public void run() {
                	onDeviceConnected();
        		}
        	}, 1500);
            return true;
        }
        return false;
    }

	private void startConnectDeviceSecure() {
		if ( mBluetoothAdapter != null ) {
			Intent serverIntent;
			serverIntent = new Intent(this, DeviceListActivity.class);
			startActivityForResult(serverIntent, REQUEST_CONNECT_DEVICE_SECURE);
		}
	}

    private class MotorController implements JoystickMovedListener, Runnable {
    	private byte[] out = new byte[] { 0,0,0,0 };
		private float movementRange = 255f;
		private int left;
		private int right;

		private final static char RIGHT = 'a';
		private final static char LEFT = 'd';
		private final static char FWD = '1';
		private final static char BWD = '2';
		private final static char BRK = '3';
		private final static char REL = '4';
		
		public float getMovementRange() {
			return movementRange;
		}

		@Override
		public void OnMoved(int left, int right) {
			if (Math.abs(left) >= MOTOR_MIN_DRIVE || Math.abs(right) >= MOTOR_MIN_DRIVE ) {
				this.left = left;
				this.right = right;
			}
			else {
				this.left = 0;
				this.right = 0;
			}
			mHandler.removeCallbacks(this);
			mHandler.postDelayed(this, MOTOR_UI_DELAY);
		}
		
		public void run() {
			if (D) Log.d(TAG, String.format("drive(%d,%d)", left, right));
			
			out[0] = LEFT;
			out[1] = (byte)(left < 0 ? BWD : FWD);
			out[2] = (byte)(Math.abs(left));
			sendMessage(out);

			out[0] = RIGHT;
			out[1] = (byte)(right < 0 ? BWD : FWD);
			out[2] = (byte)(Math.abs(right));
			sendMessage(out);
		}

		@Override
		public void OnReleased() {
			mHandler.removeCallbacks(this);
		}
		
		@Override
		public void OnReturnedToCenter() {
			mHandler.removeCallbacks(this);
			
			out[0] = LEFT;
			out[1] = REL;
			out[2] = 0;
			sendMessage(out);
			
			out[0] = RIGHT;
			sendMessage(out);
		}
    }
    
    private class ServoController implements JoystickMovedListener, Runnable {
		private byte[] out = new byte[] { 0,0,'\n' };
		private float movementRange = 90f;
		private int pan;
		private int tilt;
		
		public float getMovementRange() {
			return movementRange;
		}
		
		@Override
		public void OnMoved(int pan, int tilt) {
			this.pan = 180 - (int) (pan + movementRange);
			this.tilt = (int) (tilt + movementRange);
			mHandler.removeCallbacks(this);
			mHandler.postDelayed(this, SERVO_UI_DELAY);
		}
		
		public void run() {
			if(D) Log.d(TAG, String.format("look(%d,%d)", pan, tilt));
			
			out[0] = 'e';
			out[1] = (byte)pan;
			sendMessage(out);
				
			out[0] = 'f';
			out[1] = (byte)tilt;
			sendMessage(out);
		}

		@Override
		public void OnReleased() {
			mHandler.removeCallbacks(this);
		}
		
		@Override
		public void OnReturnedToCenter() {
			mHandler.removeCallbacks(this);
			
			out[0] = 'e';
			out[1] = (byte)90;
			sendMessage(out);
				
			out[0] = 'f';
			out[1] = (byte)90;
			sendMessage(out);
		}
    }
    
    private class VolumeControl implements OnSeekBarChangeListener {
		private byte[] out = new byte[] { 'v', 50, '\n' };
		
		@Override
		public void onStopTrackingTouch(SeekBar seekBar) {
		}
		
		@Override
		public void onStartTrackingTouch(SeekBar seekBar) {
		}
		
		@Override
		public void onProgressChanged(SeekBar seekBar, int progress, boolean fromUser) {
			setVolume(progress);
		}
		
		int a = 50;
		int z = 95;
		float s = (z - a) / 100.0f;
		public void setVolume(int progress) {
			int p = a + ((int)(progress * s));
			if ( p == a )
				p = 0;
			if(D) Log.d(TAG, String.format("volume(%d)", p));			
			out[1] = (byte)p;
			sendMessage(out);
			prefs.setLastVolume(progress);
		}
    }
}

