package com.MobileAnarchy.Android.WidgetsDemo;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.view.View.OnClickListener;

public class MainActivity extends Activity {
	/** Called when the activity is first created. */
	@Override
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		
		openActivity(R.id.ButtonThreasholdEditText, ThresholdEditTextActivity.class);
		openActivity(R.id.ButtonDockPanelHorizontal, DockPanelHorizontalActivity.class);
		openActivity(R.id.ButtonDockPanelVertical, DockPanelVerticalActivity.class);
		openActivity(R.id.ButtonJoystick, JoystickActivity.class);
		openActivity(R.id.ButtonTilesLayout, TilesLayoutActivity.class);
		openActivity(R.id.ButtonSortableList, SortableListActivity.class);
		openActivity(R.id.ButtonDragAndDrop, DragAndDropActivity.class);
	}
	
	private void openActivity(int buttonId, final Class<?> activityClass) {
		findViewById(buttonId).setOnClickListener(new OnClickListener() {
			@Override
			public void onClick(View v) {
				Intent intent = new Intent(v.getContext(), activityClass);
				startActivity(intent);
			}
		});
	}
	
}