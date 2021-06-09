Class {
	#name : #RandomEventManagerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #assertions }
RandomEventManagerTest >> assert: events areDistributedBasedOn: eventsDistribution withTolerance: tolerance [
	eventsDistribution do:[ :probabilityEvent | self assert: (self relativeEventOcurrenceOf: probabilityEvent in:events) < tolerance] 
	
]

{ #category : #tests }
RandomEventManagerTest >> groupProbabilityEventsOfCowsWith: cowsProbability piggsWith: piggsProbability horsesWith: horsesProbability andDucksWith: ducksProbability [
	|eventVaca eventsDistribution eventChanchito eventCaballo eventPato |
	eventVaca := ProbabilityEvent with: cowsProbability of: #Vaca.
	eventChanchito := ProbabilityEvent with: piggsProbability of: #Chanchito.
	eventCaballo := ProbabilityEvent with: horsesProbability of: #Caballo.
	eventPato := ProbabilityEvent with: ducksProbability of: #Pato.
	eventsDistribution:= OrderedCollection newFrom: { eventVaca. eventChanchito. eventCaballo.eventPato }.
	^eventsDistribution.
]

{ #category : #asserting }
RandomEventManagerTest >> relativeEventOcurrenceOf: aProbabilityEvent in: events [ 
	| numberOfOcurrences percentageOfOcurrences relativePercentageOfOCurrences |
	numberOfOcurrences:= events count: [ :event | event = (aProbabilityEvent event)].
	percentageOfOcurrences := numberOfOcurrences / (events size).
	relativePercentageOfOCurrences := (percentageOfOcurrences - (aProbabilityEvent probability ))abs.
	^relativePercentageOfOCurrences*100.


]

{ #category : #tests }
RandomEventManagerTest >> testAProbabilityOfAnEventCannotBeGreaterThanOne [
	self 
		should:[ProbabilityEvent with: 2.0 of: #Chanchito ] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A Probability must be a number bigger than 0 and smaller or equal to 1' ].
]

{ #category : #tests }
RandomEventManagerTest >> testAProbabilityOfAnEventCannotBeNegative [
	self 
		should:[ProbabilityEvent with: (0.25 negated) of: #Chanchito] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'A Probability must be a number bigger than 0 and smaller or equal to 1' ].
]

{ #category : #tests }
RandomEventManagerTest >> testARandomManagerCreatesAFarmWhithAllPigglets [
	| eventManager farm eventChanchito eventsDistribution |
	eventChanchito := ProbabilityEvent with: 1.0 of: #Chanchito.
	eventsDistribution := OrderedCollection newFrom: {eventChanchito}.
	eventManager := RandomProbabilityEventManager basedOn: eventsDistribution.
	farm := eventManager generate: 100.
	self
		assert: farm
		equals: (OrderedCollection new: 100 withAll: #Chanchito)
]

{ #category : #tests }
RandomEventManagerTest >> testProbabilityEqualsTo25PercentInProbabilityEvent [
	| event |
	event := ProbabilityEvent with: 0.25 of: #Chanchito.
	self assert: event probability identicalTo: 0.25
]

{ #category : #tests }
RandomEventManagerTest >> testProbabilityOfAnEvenIsGreaterThanZero [
	| event |
	event := ProbabilityEvent with: 0.25 of: #Chanchito.
	self assert: (event probability) > 0.
]

{ #category : #tests }
RandomEventManagerTest >> testTheAdditionOfTheProbabilityOfAllProbabiliyEventsCannotBeOtherThanOne [
	| eventsDistribution |
	eventsDistribution  := self groupProbabilityEventsOfCowsWith: 0.2 piggsWith: 0.05 horsesWith:0.3 andDucksWith: 0.4.
	self 
		should:[RandomProbabilityEventManager basedOn: eventsDistribution] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The addition of the probabilities of the events must be one' ].
]

{ #category : #tests }
RandomEventManagerTest >> testTheAdditionOfTheProbabilityOfAllProbabiliyEventsEqualsOne [
	| eventsDistribution eventManager |
	eventsDistribution  := self groupProbabilityEventsOfCowsWith: 0.25 piggsWith: 0.05 horsesWith:0.3 andDucksWith: 0.4.
	eventManager := RandomProbabilityEventManager basedOn: eventsDistribution.

	self assert: (eventManager sumUpEventProbabilitiesOf: eventsDistribution ) = 1.0.
]

{ #category : #tests }
RandomEventManagerTest >> testTheEventMangerCanNotBeInitializeWithAnEmptyCollection [
	| eventsDistribution  |
	eventsDistribution  := { }.

	self 
		should:[RandomProbabilityEventManager basedOn: eventsDistribution.] 
		raise: Error 
		withExceptionDo: [:error | self assert: error messageText equals: 'The Event Manager can not be instanced with an empty collection of events' ].
]

{ #category : #tests }
RandomEventManagerTest >> testsARandomEventManagerGeneratesAFarmWithPlentyAnimalsWithAGivenDistribution [
| eventsDistribution eventManager events |
	eventsDistribution  := self groupProbabilityEventsOfCowsWith: 0.25 piggsWith: 0.15 horsesWith:0.2 andDucksWith: 0.4.
	eventManager:= RandomProbabilityEventManager basedOn: eventsDistribution.
	events:= eventManager generate:1000.
	self assert: events areDistributedBasedOn: eventsDistribution withTolerance: 5.
]
