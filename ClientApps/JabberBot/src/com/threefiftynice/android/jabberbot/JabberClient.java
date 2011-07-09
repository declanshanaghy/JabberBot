package com.threefiftynice.android.jabberbot;

public class JabberClient {
	private JabberBot bot;

	public JabberClient(JabberBot bot) {
		this.bot = bot;
	}
	
	public void stopSound(int addr) {
		bot.sendMessage(new byte[] { 's', (byte)addr });		
	}

	public void playSound(int addr, int loops, int id) {
		bot.sendMessage(new byte[] { 'p', (byte)addr, (byte)loops, (byte)id });		
	}

	public void sendReset() {
		bot.sendMessage(new byte[] { 'z' });
	}    
}
