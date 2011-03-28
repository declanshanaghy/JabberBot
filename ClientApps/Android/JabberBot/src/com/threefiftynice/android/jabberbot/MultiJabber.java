package com.threefiftynice.android.jabberbot;

import com.MobileAnarchy.Android.Widgets.Joystick.DualJoystickView;
import com.MobileAnarchy.Android.Widgets.Joystick.JoystickMovedListener;

import android.app.Activity;
import android.content.pm.PackageManager;
import android.os.Bundle;
import android.util.Log;

public class MultiJabber extends Activity {
	protected static final String TAG = MultiJabber.class.getSimpleName();
	private DualJoystickView vJoystick;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.dualstick);
		setupUI();
		
		PackageManager pm = getPackageManager();
		
		boolean mt = pm.hasSystemFeature(PackageManager.FEATURE_TOUCHSCREEN_MULTITOUCH);
		boolean mtd = pm.hasSystemFeature(PackageManager.FEATURE_TOUCHSCREEN_MULTITOUCH_DISTINCT);
		
		Log.d(TAG, "************************MT=" + mt);
		Log.d(TAG, "************************MTD=" + mtd);
	}

	private void setupUI() {
		vJoystick = (DualJoystickView)findViewById(R.id.vJoystick);
		vJoystick.setLeftJostickMovedListener(new JoystickMovedListener() {
			@Override
			public void OnMoved(int pan, int tilt) {
//				Log.d(TAG, String.format("LEFT: %d, %d", pan, tilt));
			}

			@Override
			public void OnReleased() {
//				Log.d(TAG, "LEFT: RELEASED");
			}

			@Override
			public void OnReturnedToCenter() {
//				Log.d(TAG, "LEFT: CENTERED");
			}
		});
		vJoystick.setRightJostickMovedListener(new JoystickMovedListener() {
			@Override
			public void OnMoved(int pan, int tilt) {
//				Log.d(TAG, String.format("RIGHT: %d, %d", pan, tilt));
			}

			@Override
			public void OnReleased() {
//				Log.d(TAG, "RIGHT: RELEASED");
			}

			@Override
			public void OnReturnedToCenter() {
//				Log.d(TAG, "RIGHT: CENTERED");
			}
		});
	}
}
