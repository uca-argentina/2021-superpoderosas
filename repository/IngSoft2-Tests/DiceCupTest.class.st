Class {
	#name : #DiceCupTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceCupTest >> testADiceCanAnswerWithTheMaxResultPossible [
 	|firstDice secondDice thirdDice aGroupOfDices aDiceCup |
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aDiceCup:= DiceCup containing: aGroupOfDices.
		
	self assert: (aDiceCup max) equals: 22.
]

{ #category : #tests }
DiceCupTest >> testADiceCupMustHaveAtLeastOneDice [
	| aGroupOfDices|
	aGroupOfDices := {}.

	self 
		should:[DiceCup containing: aGroupOfDices.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A dice cup must contain at leaste ONE dice'].
]

{ #category : #tests }
DiceCupTest >> testWhenThrowingADiceCupWeObtainACertainValue [
 	|firstDice secondDice thirdDice aGroupOfDices aDiceCup |
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aDiceCup:= DiceCup containing: aGroupOfDices.
		
	self assert: (aDiceCup throw) equals: 14.
]
