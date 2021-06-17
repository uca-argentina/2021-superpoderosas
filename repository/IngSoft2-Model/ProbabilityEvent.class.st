Class {
	#name : #ProbabilityEvent,
	#superclass : #Object,
	#instVars : [
		'event',
		'probability'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
ProbabilityEvent class >> with: aProbability of: anEvent [
	^ self new initializeWith: aProbability of: anEvent.
]

{ #category : #'error messages' }
ProbabilityEvent >> errorMessageAProbabilityMustBeANumberBetweenOneAndZero [
	^ 'A Probability must be a number bigger than 0 and smaller or equal to 1'
]

{ #category : #validations }
ProbabilityEvent >> evaluateIfValid: aProbability [ 
	((aProbability > 1.0) or: (aProbability <= 0.0))
		ifTrue: [ Error signal: self errorMessageAProbabilityMustBeANumberBetweenOneAndZero].
]

{ #category : #accessing }
ProbabilityEvent >> event [
	^event
]

{ #category : #initialize }
ProbabilityEvent >> initializeWith: aProbability of: anEvent [
	self evaluateIfValid: aProbability.
	event:= anEvent.
	probability:= aProbability. 
	
]

{ #category : #accessing }
ProbabilityEvent >> probability [
	^ probability
]
