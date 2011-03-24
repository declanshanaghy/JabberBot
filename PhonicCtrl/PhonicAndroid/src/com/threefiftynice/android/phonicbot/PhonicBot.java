package com.threefiftynice.android.phonicbot;

import android.app.Activity;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.content.res.Configuration;
import android.os.Bundle;
import android.os.Handler;
import android.os.Message;
import android.util.Log;
import android.view.Display;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.Window;
import android.view.WindowManager;
import android.widget.TextView;
import android.widget.Toast;

import com.MobileAnarchy.Android.Widgets.Joystick.JoystickMovedListener;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickView;

public class PhonicBot extends Activity {
	protected static final String TAG = PhonicBot.class.getSimpleName();
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

	private JoystickView jvDrive, jvLook;
	private BluetoothAdapter mBluetoothAdapter;
	private BluetoothClient mBTClient;
	private TextView mTitle;
    private String mConnectedDeviceName;
	
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
                    enableUI();
                    break;
                case BluetoothClient.STATE_FAILED:
                	startConnectDeviceSecure();
                    break;
                }
                break;
            case MESSAGE_WRITE:
                byte[] writeBuf = (byte[]) msg.obj;
                // construct a string from the buffer
                String writeMessage = new String(writeBuf);
                Log.d(TAG, writeMessage);
                break;
            case MESSAGE_READ:
                byte[] readBuf = (byte[]) msg.obj;
                // construct a string from the valid bytes in the buffer
                String readMessage = new String(readBuf, 0, msg.arg1);
                Log.d(TAG, readMessage);
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
        if (mBluetoothAdapter == null) {
            Toast.makeText(this, "Bluetooth is not available", Toast.LENGTH_LONG).show();
            finish();
            return;
        }

        // Initialize the BluetoothChatService to perform bluetooth connections
        mBTClient = new BluetoothClient(this, mHandler);
        
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
        if (!mBluetoothAdapter.isEnabled()) {
            Intent enableIntent = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(enableIntent, REQUEST_ENABLE_BT);
        // Otherwise, setup the chat session
        } else {
            startConnectDeviceSecure();
        }
    }

    private void connectDevice(Intent data, boolean secure) {
        // Get the device MAC address
        String address = data.getExtras()
            .getString(DeviceListActivity.EXTRA_DEVICE_ADDRESS);
        // Get the BLuetoothDevice object
        BluetoothDevice device = mBluetoothAdapter.getRemoteDevice(address);
        // Attempt to connect to the device
        mBTClient.connect(device, secure);
    }

    public void onActivityResult(int requestCode, int resultCode, Intent data) {
        if(D) Log.d(TAG, "onActivityResult " + resultCode);
        switch (requestCode) {
        case REQUEST_CONNECT_DEVICE_SECURE:
            // When DeviceListActivity returns with a device to connect
            if (resultCode == Activity.RESULT_OK)
                connectDevice(data, true);
            else
            	finish();
            break;
        case REQUEST_CONNECT_DEVICE_INSECURE:
            // When DeviceListActivity returns with a device to connect
            if (resultCode == Activity.RESULT_OK)
                connectDevice(data, false);
            else
            	finish();
            break;
        case REQUEST_ENABLE_BT:
            // When the request to enable Bluetooth returns
            if (resultCode == Activity.RESULT_OK) {
                // Bluetooth is now enabled, so set up a chat session
                startConnectDeviceSecure();
            } else {
                // User did not enable Bluetooth or an error occured
                Log.d(TAG, "BT not enabled");
                Toast.makeText(this, "BT not enabled, exiting", Toast.LENGTH_SHORT).show();
                finish();
            }
        }
    }

    /**
     * Sends a message.
     * @param message  A string of text to send.
     */
    private void sendMessage(String message) {
        // Check that we're actually connected before trying anything
        if (mBTClient.getState() != BluetoothClient.STATE_CONNECTED) {
            Toast.makeText(this, "Not connected", Toast.LENGTH_SHORT).show();
            return;
        }

        // Check that there's actually something to send
        if (message.length() > 0) {
            // Get the message bytes and tell the BluetoothChatService to write
            byte[] send = message.getBytes();
            mBTClient.write(send);
        }
    }

    //Converts -10...10 -> 0...180
    private int joyToServo(int j, int sensitivity) {
    	j += sensitivity;	//make positive
    	return j * ((sensitivity * 2) / 180);
    }
    
    private void enableUI() {
		jvDrive.setEnabled(true);
		jvDrive.setOnJostickMovedListener( new JoystickMovedListener() {
			@Override
			public void OnMoved(int pan, int tilt) {
				Log.i(TAG, "drive: " + pan + "," + tilt);
			}

			@Override
			public void OnReleased() {
			}
		});
		jvLook.setEnabled(true);
		jvLook.setOnJostickMovedListener( new JoystickMovedListener() {
			private int pan;
			private int tilt;

			@Override
			public void OnMoved(int pan, int tilt) {
				if ( Math.abs(this.pan - pan) > 2 ) {
					this.pan = pan;
					Log.i(TAG, "pan: " + pan);
					sendMessage("e" + String.valueOf(joyToServo(pan, jvDrive.getSensitivity())) + "\n");
				}
					
				if ( Math.abs(this.tilt - tilt) > 2 ) {
					this.tilt = tilt;
					Log.i(TAG, "tilt: " + tilt);
					sendMessage("f" + String.valueOf(joyToServo(tilt, jvLook.getSensitivity())) + "\n");
				}
			}

			@Override
			public void OnReleased() {
				sendMessage("e90\n");
				sendMessage("f90\n");
			}
		});
    }
    
	private void setupUI() {
		jvDrive = (JoystickView)findViewById(R.id.jvDrive);
		jvDrive.setEnabled(false);
		jvDrive.setSensitivity(90);
		jvLook = (JoystickView)findViewById(R.id.jvLook);
		jvLook.setEnabled(false);
		jvLook.setSensitivity(90);
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
		Intent serverIntent;
		serverIntent = new Intent(this, DeviceListActivity.class);
		startActivityForResult(serverIntent, REQUEST_CONNECT_DEVICE_SECURE);
	}
}

