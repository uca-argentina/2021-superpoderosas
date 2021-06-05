Class {
	#name : #RandomProbabilityEventManager,
	#superclass : #Object,
	#instVars : [
		'events'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomProbabilityEventManager class >> basedOn: events [ 
	^self new initializeBasedOn: events.
]

{ #category : #'error messages' }
RandomProbabilityEventManager >> errorMessageTheAdditionOfTheEventsProbabilitiesMustBeOne [
	^ 'The addition of the probabilities of the events must be one'
]

{ #category : #validations }
RandomProbabilityEventManager >> evaluateIfValid: aGroupOfEvents [
	((self sumUpEventProbabilitiesOf: aGroupOfEvents) = 1.0)
		ifFalse: [ Error
				signal: self errorMessageTheAdditionOfTheEventsProbabilitiesMustBeOne ]
]

{ #category : #actions }
RandomProbabilityEventManager >> generate: size [ 
	^ OrderedCollection new: size withAll:((events first) event).
]

{ #category : #initialize }
RandomProbabilityEventManager >> initializeBasedOn: aGroupOfEvents [
	self evaluateIfValid: aGroupOfEvents.
	events:= aGroupOfEvents.
]

{ #category : #actions }
RandomProbabilityEventManager >> sumUpEventProbabilitiesOf: aGroupOfEvents [ 
	^ aGroupOfEvents sumNumbers: [ :event | event probability ].
]
