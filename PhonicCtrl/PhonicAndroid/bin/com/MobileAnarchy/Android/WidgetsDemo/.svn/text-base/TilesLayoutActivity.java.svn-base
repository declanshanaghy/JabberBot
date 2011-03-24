package com.MobileAnarchy.Android.WidgetsDemo;

import com.MobileAnarchy.Android.Widgets.TilesLayout.TilesLayout;
import com.MobileAnarchy.Android.Widgets.TilesLayout.TilesLayoutPreset;

import android.app.Activity;
import android.os.Bundle;
import android.os.Handler;
import android.view.Gravity;
import android.view.Menu;
import android.view.MenuInflater;
import android.view.MenuItem;
import android.view.View;
import android.view.View.OnClickListener;
import android.widget.Button;
import android.widget.FrameLayout;

public class TilesLayoutActivity extends Activity {

	// =========================================
	// Private Members
	// =========================================

	private TilesLayout tileLayout;
	private Handler handler;

	// =========================================
	// UI Events
	// =========================================

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.tileslayout);
		
		tileLayout = (TilesLayout)findViewById(R.id.tileLayout);
		
		handler = new Handler();
		
		// We need to let the UI finish it's drawing before we can build the layout
		handler.postDelayed(new Runnable() {

			@Override
			public void run() {
				tileLayout.setPreset(TilesLayoutPreset.get2x3x3());
			}
			
		}, 100);
	
	}

	// =========================================
	// Input Events
	// =========================================

	@Override
	public boolean onCreateOptionsMenu(Menu menu) {
		MenuInflater inflater = getMenuInflater();
	    inflater.inflate(R.menu.tileslayout, menu);
	    return true;
	}


	@Override
	public boolean onOptionsItemSelected(MenuItem item) {
		switch (item.getItemId()) {
		case R.id.menu_item1by1: 
			tileLayout.setPreset(TilesLayoutPreset.get1x1());
			break;
		case R.id.menu_item2by2: 
			tileLayout.setPreset(TilesLayoutPreset.get2x2());
			break;
		case R.id.menu_item3by3: 
			tileLayout.setPreset(TilesLayoutPreset.get3x3());
			break;
		case R.id.menu_item3by2: 
			tileLayout.setPreset(TilesLayoutPreset.get3x2());
			break;
		case R.id.menu_item2by3: 
			tileLayout.setPreset(TilesLayoutPreset.get2x3());
			break;
		case R.id.menu_item4by4: 
			tileLayout.setPreset(TilesLayoutPreset.get4x4());
			break;
		case R.id.menu_item2by3by3: 
			tileLayout.setPreset(TilesLayoutPreset.get2x3x3());
			break;
		}
		return true;
	}
	
	
}
