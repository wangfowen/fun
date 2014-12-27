package grapefruit.namespace;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.EditText;
import android.widget.Button;

public class GameActivity extends Activity {
	private TextView turnText;
	private TextView prevLine;
	private EditText currentLine;
	int turnsTaken = 0;
	String[] story;
	int numTurns;
	
	public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.game);
		
		numTurns = getIntent().getIntExtra("numTurns", 10);
		story = new String[numTurns];
		turnText = (TextView) findViewById(R.id.turnsText);
		turnText.setText((numTurns - turnsTaken) + " lines remaining");
		prevLine = (TextView) findViewById(R.id.prevLine);
		prevLine.setText("You are the first writer, brave soul");
		currentLine = (EditText) findViewById(R.id.currentLine);
		
	}
	
	public void writeLine(View view) {
		story[turnsTaken] = currentLine.getText().toString();
		prevLine.setText(story[turnsTaken]);
		turnsTaken++;
		if (numTurns - turnsTaken == 1) {
			turnText.setText("1 line remaining");
		}
		else {
			turnText.setText((numTurns - turnsTaken) + " lines remaining");
		}
		currentLine.setText("");
		
		if (turnsTaken == numTurns) {
			endGamePhase();
		}
	}
	
	public void endGamePhase() {
		Button endTurn = (Button) findViewById(R.id.button1);
		((LinearLayout) currentLine.getParent()).removeView(currentLine);
		((LinearLayout) endTurn.getParent()).removeView(endTurn);
		
		Button endGame = (Button) findViewById(R.id.button2);
		endGame.setVisibility(View.VISIBLE);
	}
	
	public void endGame(View view) {
		Intent i = new Intent(GameActivity.this, ViewStoryActivity.class);
		i.putExtra("story", story);
		startActivity(i);
		finish();
	}
	
}
