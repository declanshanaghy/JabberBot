package com.MobileAnarchy.Android.WidgetsDemo;

import com.MobileAnarchy.Android.Widgets.DragAndDrop.DragAndDropManager;
import com.MobileAnarchy.Android.Widgets.DragAndDrop.DragSurface;
import com.MobileAnarchy.Android.Widgets.DragAndDrop.DraggableItem;
import com.MobileAnarchy.Android.Widgets.DragAndDrop.DraggableViewsFactory;
import com.MobileAnarchy.Android.Widgets.DragAndDrop.DropZone;
import com.MobileAnarchy.Android.Widgets.DragAndDrop.DropZoneEventsListener;

import android.app.Activity;
import android.graphics.Color;
import android.os.Bundle;
import android.view.MotionEvent;
import android.view.View;
import android.view.View.OnTouchListener;
import android.widget.TextView;
import android.widget.Toast;

public class DragAndDropActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.draganddrop);
		
		// Init Drag & Drop Manager
		DragSurface dragSurface = (DragSurface)findViewById(R.id.dragsurface);
		DragAndDropManager.getInstance().init(dragSurface);
		
		// Setup the 2 drop zones
		DropZone dropzone1 = new DropZone(findViewById(R.id.FrameLayoutDropZone1), dropzoneListener);
		DragAndDropManager.getInstance().addDropZone(dropzone1);

		DropZone dropzone2 = new DropZone(findViewById(R.id.FrameLayoutDropZone2), dropzoneListener);
		DragAndDropManager.getInstance().addDropZone(dropzone2);

		// Setup the 2 draggable objects
		TextView txt1 = (TextView)findViewById(R.id.TextViewDraggable1);
		txt1.setOnTouchListener(onTouchListener);
		
		TextView txt2 = (TextView)findViewById(R.id.TextViewDraggable2);
		txt2.setOnTouchListener(onTouchListener);
	}

	
	private OnTouchListener onTouchListener = new OnTouchListener() {
		
		@Override
		public boolean onTouch(View v, MotionEvent event) {
			if (event.getAction() == MotionEvent.ACTION_DOWN)
			{
				String txt = ((TextView)v).getText().toString();

				DraggableItem draggedItem = new DraggableItem(v, 
						DraggableViewsFactory.getLabel("Drop [" + txt + "]"));

				// Start dragging
				DragAndDropManager.getInstance().startDragging(this, draggedItem);
				
				return true;
			}
			return false;
		}
	};
	
	
	private DropZoneEventsListener dropzoneListener = new DropZoneEventsListener() {

		@Override
		public void OnDragZoneEntered(DropZone zone, DraggableItem item) {
			zone.getView().setBackgroundColor(Color.YELLOW);
		}

		@Override
		public void OnDragZoneLeft(DropZone zone, DraggableItem item) {
			zone.getView().setBackgroundColor(Color.parseColor("#999999"));
		}

		@Override
		public void OnDropped(DropZone zone, DraggableItem item) {
			zone.getView().setBackgroundColor(Color.parseColor("#999999"));
			Toast.makeText(DragAndDropActivity.this, "Dropped", 1000).show();
		}
		
	};
	
}
