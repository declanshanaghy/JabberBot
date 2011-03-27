package com.threefiftynice.android.jabberbot;

import java.util.Arrays;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
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

import com.MobileAnarchy.Android.Widgets.Joystick.JoystickClickedListener;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickMovedListener;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickView;

public class JabberBot extends Activity {
	protected static final String TAG = JabberBot.class.getSimpleName();
	private static final boolean D = false;

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
                    break;
                case BluetoothClient.STATE_FAILED:
                	mTitle.setText("Connection lost :-(");
                	if ( mBluetoothAdapter != null )
                		startConnectDeviceSecure();
                    break;
                }
                break;
            case MESSAGE_WRITE:
                byte[] writeBuf = (byte[]) msg.obj;
                String writeMessage = new String(writeBuf);
                Log.d(TAG, "TX: \"" + writeMessage + "\"");
                break;
            case MESSAGE_READ:
            	try {
            		byte[] readBuf = (byte[]) msg.obj;
    				String readMessage = new String(readBuf, 0, msg.arg1);
                    Log.d(TAG, "RX: \"" + readMessage + "\"");
            	}
            	catch ( Exception ex) {
            		Log.e(TAG, ex.getMessage(), ex);
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

	private enum JoyStickState { Drive, Look };
	private JoyStickState jvState = JoyStickState.Look;
	
	private ServoController servoController;
	private MotorController motorController;

	private BluetoothClient mBTClient;
	private TextView mTitle;
    private String mConnectedDeviceName;

	private BluetoothAdapter mBluetoothAdapter;

	private JoystickView vJoystick;
	private TextView vJoystickStatus;
	private SeekBar vVol;

    @Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);

        // Set up the window layout
        requestWindowFeature(Window.FEATURE_CUSTOM_TITLE);
		setContentView(R.layout.phonic);
        getWindow().setFeatureInt(Window.FEATURE_CUSTOM_TITLE, R.layout.custom_title);

        // Set up the custom title
        mTitle = (TextView) findViewById(R.id.title_left_text);
        mTitle.setText(R.string.app_name);
        mTitle = (TextView) findViewById(R.id.title_right_text);

        mBluetoothAdapter = BluetoothAdapter.getDefaultAdapter();
        if (mBluetoothAdapter != null) {
            // Initialize the BluetoothChatService to perform bluetooth connections
        	mBTClient = new BluetoothClient(this, mHandler);
        }
//        else {
//          Toast.makeText(this, "Bluetooth is not available", Toast.LENGTH_LONG).show();
//          finish();
//          return;
//        }
        
		setupUI();			
	}

    @Override
    public void onDestroy() {
        super.onDestroy();
        // Stop the Bluetooth service
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
                startConnectDeviceSecure();
            }
        }
    }

    private void connectDevice(Intent data, boolean secure) {
        if (mBluetoothAdapter != null) {
            // Get the device MAC address
            String address = data.getExtras()
                .getString(DeviceListActivity.EXTRA_DEVICE_ADDRESS);
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

    private void sendMessage(byte[]send) {
    	sendMessage(send, 0, send.length);
    }
    
    private void sendMessage(byte[]send, int len) {
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
		vJoystickStatus = (TextView)findViewById(R.id.vJoystickStatus);
		
		vVol = (SeekBar)findViewById(R.id.vVol);
		vVol.setOnSeekBarChangeListener(new VolumeControl());
		vVol.setProgress(50);
		
		Button bRandom = (Button)findViewById(R.id.bRandom);
		bRandom.setOnClickListener(new OnClickListener() {
			byte[] random = new byte[] { 'r' };
			@Override
			public void onClick(View v) {
				sendMessage(random);
			}
		});
		
		servoController = new ServoController();
		motorController = new MotorController();

		vJoystick = (JoystickView)findViewById(R.id.vJoystick);
		vJoystick.setMovementConstraint(JoystickView.CONSTRAIN_CIRCLE);
		vJoystick.setYAxisInverted(false);
		setJoystickState(JoyStickState.Drive);

		vJoystick.setOnJostickClickedListener(new JoystickClickedListener() {
			@Override
			public void OnReleased() {
				switch ( jvState ) {
				case Look:
					setJoystickState(JoyStickState.Drive);
					break;
				case Drive:
					setJoystickState(JoyStickState.Look);
					break;
				}
			}
			
			@Override
			public void OnClicked() {
			}
		});
	}
	
    private void setJoystickState(JoyStickState s) {
		switch ( s ) {
		case Drive:
			vJoystickStatus.setText("Drive");
			servoController.releaseControl(vJoystick);
			motorController.takeControl(vJoystick);
			jvState = JoyStickState.Drive;
			break;
		case Look:
			vJoystickStatus.setText("Look");
			motorController.releaseControl(vJoystick);
			servoController.takeControl(vJoystick);
			jvState = JoyStickState.Look;
			break;
		}
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
        case R.id.secure_connect_scan:
            startConnectDeviceSecure();
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
    	private byte[] out = new byte[] { 0,0,0 };
		private float movementRange = 255f;
		private int pan;
		private int tilt;

		private final static char RIGHT = 'a';
		private final static char LEFT = 'd';
		private final static char FWD = '1';
		private final static char BWD = '2';
		private final static char BRK = '3';
		private final static char REL = '4';
		
		public float getMovementRange() {
			return movementRange;
		}
		
		public void releaseControl(JoystickView vJoystick) {
			OnReturnedToCenter();
		}

		public void takeControl(JoystickView vJoystick) {
			vJoystick.setOnJostickMovedListener(this);
			vJoystick.setMovementRange(getMovementRange());
			vJoystick.setMoveResolution(5f);
			vJoystick.setUserCoordinateSystem(JoystickView.COORDINATE_DIFFERENTIAL);
		}

		@Override
		public void OnMoved(int pan, int tilt) {
			this.pan = pan;
			this.tilt = tilt;
			mHandler.removeCallbacks(this);
			mHandler.postDelayed(this, 50);
		}
		
		public void run() {
			Log.d(TAG, String.format("drive(%d,%d)", pan, tilt));
			out[0] = LEFT;
			out[1] = (byte)(pan < 0 ? BWD : FWD);
			out[2] = (byte)(Math.abs(pan));
			sendMessage(out);
			
			out[0] = RIGHT;
			out[1] = (byte)(tilt < 0 ? BWD : FWD);
			out[2] = (byte)(Math.abs(tilt));
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
			out[1] = BRK;
			out[2] = '\n';
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
		
		public void releaseControl(JoystickView vJoystick) {
			mHandler.removeCallbacks(this);
		}

		public void takeControl(JoystickView vJoystick) {
			vJoystick.setOnJostickMovedListener(this);
			vJoystick.setMovementRange(getMovementRange());
			vJoystick.setMoveResolution(5.0f);
			vJoystick.setUserCoordinateSystem(JoystickView.COORDINATE_CARTESIAN);
		}

		@Override
		public void OnMoved(int pan, int tilt) {
			this.pan = (int) (pan + movementRange);
			this.tilt = (int) (tilt + movementRange);
			mHandler.removeCallbacks(this);
			mHandler.postDelayed(this, 100);
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
			out[1] = (byte)progress;
			if(D) Log.d(TAG, String.format("volume(%d)", progress));			
			sendMessage(out);
		}
    }
}

