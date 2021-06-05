Class {
	#name : #RandomProbabilityEventManager,
	#superclass : #Object,
	#instVars : [
		'poolOfEvents'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
RandomProbabilityEventManager class >> basedOn: eventsDistribution [ 
	^self new initializeBasedOn: eventsDistribution.
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
	| events |
	events := OrderedCollection new.
	size timesRepeat: [ events add: (poolOfEvents atRandom: (Random new))].
	 ^events.
]

{ #category : #initialize }
RandomProbabilityEventManager >> initializeBasedOn: eventDistribution [
	self evaluateIfValid: eventDistribution.
	poolOfEvents := OrderedCollection new.
	eventDistribution do: [:event | poolOfEvents add: (event event) withOccurrences: (event probability * 100) asInteger].

]

{ #category : #actions }
RandomProbabilityEventManager >> sumUpEventProbabilitiesOf: aGroupOfEvents [ 
	^ aGroupOfEvents sumNumbers: [ :event | event probability ].
]
