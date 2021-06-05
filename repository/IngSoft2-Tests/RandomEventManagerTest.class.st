Class {
	#name : #RandomEventManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RandomEventManagerTest >> testAFarmHasAllCows [
	|eventVaca events eventManager farm |
	eventVaca := ProbabilityEvent with: 1.0 of: #Vaca.
	events:= OrderedCollection newFrom: { eventVaca}.
	eventManager:= RandomProbabilityEventManager basedOn: events.
	farm:= eventManager generate: 100.
	self assert: farm equals: (OrderedCollection new:100 withAll: #Vaca).
]

{ #category : #tests }
RandomEventManagerTest >> testAProbabilityCannotBeGreaterThanOne [
	self 
		should:[ProbabilityEvent with: 2.0 of: #Chanchito ] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A Probability must be a number bigger than 0 and smaller or equal to 1' ].
]

{ #category : #tests }
RandomEventManagerTest >> testAProbabilityCannotBeNegative [
	self 
		should:[ProbabilityEvent with: (0.25 negated) of: #Chanchito] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A Probability must be a number bigger than 0 and smaller or equal to 1' ].
]

{ #category : #tests }
RandomEventManagerTest >> testProbabilityEqualsTo25PercentInProbabilityEvent [
	| event |
	event := ProbabilityEvent with: 0.25 of: #Chanchito.
	self assert: event probability identicalTo: 0.25
]

{ #category : #tests }
RandomEventManagerTest >> testProbabilityIsGreaterThanZero [
	| event |
	event := ProbabilityEvent with: 0.25 of: #Chanchito.
	self assert: (event probability) > 0.
]

{ #category : #tests }
RandomEventManagerTest >> testTheAdditionOfTheProbabilityOfAllProbabiliyEventsCannotBeOtherThanOne [
	|eventVaca events eventChanchito eventCaballo eventPato |
	eventVaca := ProbabilityEvent with: 0.20 of: #Vaca.
	eventChanchito := ProbabilityEvent with: 0.05 of: #Chanchito.
	eventCaballo := ProbabilityEvent with: 0.30 of: #Caballo.
	eventPato := ProbabilityEvent with: 0.40 of: #Pato.
	events:= OrderedCollection newFrom: { eventVaca. eventChanchito. eventCaballo.eventPato }.
	self 
		should:[RandomProbabilityEventManager basedOn: events] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The addition of the probabilities of the events must be one' ].
]

{ #category : #tests }
RandomEventManagerTest >> testTheAdditionOfTheProbabilityOfAllProbabiliyEventsEqualsOne [
	|eventVaca events eventManager eventChanchito eventCaballo eventPato |
	eventVaca := ProbabilityEvent with: 0.25 of: #Vaca.
	eventChanchito := ProbabilityEvent with: 0.05 of: #Chanchito.
	eventCaballo := ProbabilityEvent with: 0.30 of: #Caballo.
	eventPato := ProbabilityEvent with: 0.40 of: #Pato.
	events:= OrderedCollection newFrom: { eventVaca. eventChanchito. eventCaballo.eventPato }.
	eventManager:= RandomProbabilityEventManager basedOn: events.

	self assert: (eventManager sumUpEventProbabilitiesOf: events ) identicalTo: 1.0.
]
