package com.MobileAnarchy.Android.WidgetsDemo;

import com.MobileAnarchy.Android.Widgets.ThresholdEditText.ThresholdEditText;
import com.MobileAnarchy.Android.Widgets.ThresholdEditText.ThresholdTextChanged;

import android.app.Activity;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.widget.TextView;

public class ThresholdEditTextActivity extends Activity {
	
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.threasholdedittext);
        
		final TextView standardInput = (TextView)findViewById(R.id.TextViewStandardTextChange);
		final TextView threasholdInput = (TextView)findViewById(R.id.TextViewThreasholdTextChange);
        
        // Get the EditText reference
        ThresholdEditText editText = (ThresholdEditText)findViewById(R.id.EditTextInput);
        
        // Subscribe to the standard TextChanged events
        editText.addTextChangedListener(new TextWatcher() {

			@Override
			public void afterTextChanged(Editable arg0) {
			}

			@Override
			public void beforeTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
			}

			@Override
			public void onTextChanged(CharSequence arg0, int arg1, int arg2, int arg3) {
				standardInput.setText(arg0);
			}
        	
        });
  
        // You can manually set the threshold value (default is 500ms)
        editText.setThreshold(1000);
        
        // Subscribe to the OnTresholdTextChanged event
        editText.setOnThresholdTextChanged(new ThresholdTextChanged() {

			@Override
			public void onThersholdTextChanged(Editable text) {
				Log.d("Test", "Threshold text changed event was called - " + text.toString());
				threasholdInput.setText(text);
			}
        
        });
        
        
        
    }
}