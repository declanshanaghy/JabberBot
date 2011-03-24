package com.MobileAnarchy.Android.WidgetsDemo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.MobileAnarchy.Android.Widgets.SortableListView.TouchInterceptor;

import android.app.ListActivity;
import android.os.Bundle;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.Toast;

public class SortableListActivity extends ListActivity {

	private List<Map> list;
	private SimpleAdapter adapter;
	
	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sortablelistview);
		
		list = new ArrayList<Map>();
		for (int i = 0; i<20; i++) {
			Map map = new HashMap();
			map.put("value", "Value " + i);
			list.add(map);
		}
        
		// the from array specifies which keys from the map
		// we want to view in our ListView
		String[] from = {"value"};
		 
		// the to array specifies the TextViews from the xml layout
		// on which we want to display the values defined in the from array
		int[] to = {R.id.TextViewLine1};
		
        // Now create a new list adapter bound to the cursor.
        // SimpleListAdapter is designed for binding to a Cursor.
		adapter = new SimpleAdapter(this, (List<? extends Map<String, ?>>) list, R.layout.sortablelistview_item, from, to); 
		
        // Bind to our new adapter.
        setListAdapter(adapter);
        
        ListView mTrackList = getListView();
        mTrackList.setOnCreateContextMenuListener(this);
        mTrackList.setCacheColorHint(0);
        ((TouchInterceptor) mTrackList).setDropListener(mDropListener);
        //((SortableListView) mTrackList).setRemoveListener(mRemoveListener);
        mTrackList.setDivider(null);
	}
	
	
	private TouchInterceptor.DropListener mDropListener = new TouchInterceptor.DropListener() {
		public void drop(final int from, final int to) {
			Map item = list.get(from);
			list.remove(from);
			list.add(to, item);
			adapter.notifyDataSetChanged();

			String toast = String.format("Item moved from %d to %d", from, to);
			Toast.makeText(SortableListActivity.this, toast, 3000).show();
		}
	};

}

