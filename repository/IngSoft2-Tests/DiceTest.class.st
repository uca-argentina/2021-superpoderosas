Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #randomDiceTests }
DiceTest >> testADeterministicDiceCanAnswerWithHisMax [
	| deterministicDice aPattern |
	aPattern:=#(2 3 4 1 1 6 5).
	deterministicDice:= DeterministicDice with: aPattern.
	self assert: deterministicDice max equals: 6.
	
	
]

{ #category : #randomDiceTests }
DiceTest >> testADiceCanAnswerWithHisMax [
	| dice |
	dice:= Dice having: 6.
	self assert: dice max equals: 6.
	
	
]

{ #category : #randomDiceTests }
DiceTest >> testARandomDiceHasAtLeastTwoFaces [	
	self 
		should:[(Dice having: 0) and:(Dice having: 1).] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A random dice must have at least three faces'].
]

{ #category : #deterministicDiceTests }
DiceTest >> testWhenThrowingADeterministicDiceWeGet2 [
 	| obtainedValue aDeterministicDice aPattern |
	aPattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice with: aPattern.
	obtainedValue:= aDeterministicDice throw.		
	self assert: obtainedValue equals: 2.
]

{ #category : #deterministicDiceTests }
DiceTest >> testWhenThrowingADeterministicDiceWeGetACertainSequence [
 	| obtainedValue aDeterministicDice pattern |
	pattern:=#(2 3 4 1 1 6 5).
	aDeterministicDice:= DeterministicDice with: pattern.
	1 to:8 do:
			[ :index | obtainedValue:= aDeterministicDice throw. 
			self assert: obtainedValue equals: (#(2 3 4 1 1 6 5 2) at:index)].
	
	

	
]

{ #category : #randomDiceTests }
DiceTest >> testWhenThrowingARandomDiceWith6FacesWeCanGetAValueBetween1and6 [
 	| obtainedValue aRandomDice |
	aRandomDice:= Dice having: 6.
	obtainedValue:= aRandomDice throw.		
	self assert: (obtainedValue between: 1 and:6).
]
