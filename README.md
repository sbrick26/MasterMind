# Mastermind

Mastermind is a fun iOS game that gives the player 10 chances to guess the code of 4 numbers correctly. The user will receive feedback on each guess and can keep track of their wins and losses. The project utilizes the Integer Generator API (https://www.random.org/clients/http/api/) to randomly generate the number combinations for each game.

## Description

When starting the game, the player will see a blank board with 4 "guess" spot and 4 "feedback" spots. Using the keyboard, the player will have 10 attempts to guess the correct 4 digit code. After each code is inputted, the player will see a set of colors to indicate one of three things:

1. Gray: The number is not included in the answer.
2. Blue: The number is included in the answer, but not in the correct location.
3. Red: The number is included in the answer and is in the correct location.

Note: The player will not know which number relates to which color (the color positions are randomized)

If the player guesses the right code within 10 attempts, the game will end and the player will be prompted to start a new game.

If the player does not guess the right code within 10 attempts, the player will lose the game, and also be prompted to start a new game.

The player's overall game wins will be tracked by the application as a running count, and will be displayed to the player after each game.

## Getting Started

### Executing program

Must have XCODE installed on computer.

1. Download or Clone project to local computer with XCODE installed
2. Navigate to "MasterMind.xcodeproj" in file system and Double Click on file
3. Select target build device as "iPhone 13 Pro" at the top of XCODE (Should read: "MasterMind > iPhone 13 Pro")
4. Click on run button at top of XCODE and enjoy the game :)

WARNING: First run may take a little bit to build as XCODE must boot up the simulator and attach the game to the device. 

## Project Design

When receiving the project, I immediately got inspired by the popular game Wordle and tried to model the game design after it. The app uses dark colors and bright green text to simulate a "Code Breaker" feel. It also utilizes the "American Typewriter" font to give a hacker-type vibe to the user, as if they are really a "MasterMind" at figuring out the secret code.

The game launches with the StartView, featuring the title and Start Game button. This screen acts as a launch screen for the actual game, giving users the chance to read the title, potential instructions, and to start the game.

The game board features two custom views: BoardView and KeyBoardView. These views together create the overall gameboard that is seen when the player starts the game. The two views are Collection Views with designated Delegates and Datasources to pass information back and forth between one another, allowing for the interactive "real-time" feel of the game. The BoardView controller fixes the positions of the Board cells and displays the color for the hints. The KeyBoardView allows for the player to input their guesses, delete guesses, and start a new game. One cool feature I implemented is that the "Delete" key cannot be triggered on past guesses: once the player inputs 4 numbers into their guess, they can no longer change their answer. This allows for honest game play results. I also attempted to make the game board views programatically since I required many custom adjustments to each view, such as a custom number of keys the player can input or custom cell sizes for guess inputs and guess hints. 

These two views are subviews of the main View, which contains the game logic. In the main View, the secret code is generated utilizing the Integer Generator API to randomly generate a set of 4 numbers. This code is hidden to the player until the end of the game. When a key is inputted, the player will see the BoardView reload it's data and the key will be displayed in the next open spot. When each row is filled, the Board will then display the color hints, which are in a randomized order. The main View will also check is your guess is the correct code after each row in inputted. If it is correct, the player will be immediately taken to the ResultView. If it is in correct, you will see the color hints and can attempt again until the board is filled up with the player's 10 attempts. If the player cannot guess and the board is filled up, the the player will be taken to the ResultView.

The ResultView is populated with the game result for the player to see, either with a win message or lose message. Another cool extension I implemented was displaying a running count of the total number of wins, which is saved locally on the device. This allows for the user to exit the app and come back to a saved overall score. The count will increase only if a player has won the game. The ResultView also features a button for the user to start a new game, in which a new code will be generated and the old BoardView will be wiped clean. 



