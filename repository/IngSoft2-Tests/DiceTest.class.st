Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testADiceCupContainsThreeDices [
 	|firstDice secondDice thirdDice aGroupOfDices aDiceCup |
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with: #(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aDiceCup:= DiceCup containing: aGroupOfDices.
		
	self assert: (aDiceCup numberOfDices) identicalTo: 3.
]

{ #category : #tests }
DiceTest >> testADiceCupMustHaveAtLeastOneDice [
	| aGroupOfDices|
	aGroupOfDices := {}.

	self 
		should:[DiceCup containing: aGroupOfDices.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: DiceCup errorMessageMustHaveAtLeastOneDice].
]

{ #category : #tests }
DiceTest >> testARandomDiceHas6Faces [	
	| aRandomDice |
	aRandomDice:= RandomDice having: 6.		
	self assert: (aRandomDice hasNFaces: 6).
]

{ #category : #tests }
DiceTest >> testARandomDiceHasAtLeastTwoFaces [	
	self 
		should:[(RandomDice having: 0) and:(RandomDice having: 1).] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: RandomDice errorMessageMustHaveAtLeastThreeFaces].
]

{ #category : #tests }
DiceTest >> testWhenThrowingADeterministicDiceWeGet2 [
 	| obtainedValue aDeterministicDice aPattern |
	aPattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice with: aPattern.
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue identicalTo: 2.
]

{ #category : #tests }
DiceTest >> testWhenThrowingADeterministicDiceWeGetACertainSequence [
 	| obtainedValue aDeterministicDice pattern |
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice with: pattern.
	1 to:8 do:
			[ :index | obtainedValue:= aDeterministicDice throw. 
			self assert: obtainedValue identicalTo: (#(2 3 4 1 1 6 5 2) at:index)].
	
	

	
]

{ #category : #tests }
DiceTest >> testWhenThrowingADiceCupWeObtainACertainValue [
 	|firstDice secondDice thirdDice aGroupOfDices aDiceCup |
	firstDice:= DeterministicDice with:#(2 4 7 2).
	secondDice:= DeterministicDice with:#(8 5 4 7 2).
	thirdDice:= DeterministicDice with:#(4 1 2 7 2).
	aGroupOfDices:= { firstDice. secondDice. thirdDice}.
	aDiceCup:= DiceCup containing: aGroupOfDices.
		
	self assert: (aDiceCup throw) identicalTo: 14.
]

{ #category : #tests }
DiceTest >> testWhenThrowingARandomDiceWith6FacesWeCanGetAValueBetween1and6 [
 	| obtainedValue aRandomDice |
	aRandomDice:= RandomDice having: 6.
	obtainedValue:= aRandomDice throw.		
	self assert: (obtainedValue between: 1 and:6).
]
