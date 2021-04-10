Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testADeterministicDiceHas6Faces [	
	| aDeterministicDice |
	aDeterministicDice:= DeterministicDice newDiceWithNFaces: 6.		
	self assert: (aDeterministicDice hasNFaces: 6).
]

{ #category : #tests }
GameTest >> testARandomDiceHas6Faces [	
	| aRandomDice |
	aRandomDice:= RandomDice newDiceWithNFaces: 6.		
	self assert: (aRandomDice hasNFaces: 6).
]

{ #category : #tests }
GameTest >> testWhenThrowingADeterministicDiceWith6FacesWeGet2 [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice newDiceWithNFaces: 6 andPattern: pattern.
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue identicalTo: 2.
]

{ #category : #tests }
GameTest >> testWhenThrowingADeterministicDiceWith6FacesWeGetACertainSequence [
 	| obtainedValue aDeterministicDice pattern |
	"mas adelante agregar un bloque con un patron"
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice newDiceWithNFaces: 6 andPattern: pattern.
	1 to:7 do:
			[ :index | obtainedValue:= aDeterministicDice throw. 
			self assert: obtainedValue identicalTo: (pattern at:index)].
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue identicalTo: 2.

	

	
]

{ #category : #tests }
GameTest >> testWhenThrowingARandomDiceWith6FacesWeCanGetAValueBetween1and6 [
 	| obtainedValue aRandomDice |
	aRandomDice:= RandomDice newDiceWithNFaces: 6.
	obtainedValue:= aRandomDice throw.		
	self assert: (obtainedValue between: 1 and:6).
]
