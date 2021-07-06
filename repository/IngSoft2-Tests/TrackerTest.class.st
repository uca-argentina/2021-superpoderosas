Class {
	#name : #TrackerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
TrackerTest >> testATrackerHasAFieldNumberAndRoundNumber [
	| aPosition |
	aPosition := Tracker of: 'Pau' standingOn: 12 after: 2.
	self assert: aPosition round equals: 2.
	self assert: aPosition field equals: 12
]

{ #category : #tests }
TrackerTest >> testTwoTrackersHaveIdenticalHashes [
	| aTracker anotherTracker |
	aTracker := Tracker of: 'Pau' standingOn: 12 after: 2.
	anotherTracker := Tracker of: 'Pau' standingOn: 12 after: 2.
	self assert: aTracker hash equals: (anotherTracker hash).
]
