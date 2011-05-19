package com.threefiftynice.android.jabberbot;

import android.content.Context;
import android.content.SharedPreferences;

public class Prefs {
	private static final String DEVICE = "device";
	private static final String VOLUME = "volume";
	private SharedPreferences prefs;

	public Prefs(Context ctx) {
		prefs = ctx.getSharedPreferences("PREFS", Context.MODE_PRIVATE);
	}
	
	public String getLastConnectedDevice() {
		return prefs.getString(DEVICE, null);
	}
	
	public void setLastConnectedDevice(String device) {
		prefs.edit().putString(DEVICE, device).commit();
	}

	public int getLastVolume() {
		return prefs.getInt(VOLUME, 50);
	}
	
	public void setLastVolume(int v) {
		prefs.edit().putInt(VOLUME, v).commit();
	}
}
