Class {
	#name : #DeterministicBoard,
	#superclass : #Board,
	#instVars : [
		'fields',
		'numberOfFields'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #initialize }
DeterministicBoard >> establish: effect on: effectFields [
	^ effectFields do: [ :fieldNumber | fields at: fieldNumber put: effect ].
]

{ #category : #initialize }
DeterministicBoard >> initializeSize: aNumberOfFields [
	| effectToDistrubute effectDistributionFields |
	numberOfFields := aNumberOfFields.
	fields := OrderedCollection
		new: aNumberOfFields
		withAll: NoEffect new.
	effectToDistrubute := {WormHoleEffect new.
	SpeedUpEffect new.
	AtomicBombEffect new.
	MoonWalkEffect new}.
	effectDistributionFields := {{3 . 17}.
	{30 . 48}.
	{44}.
	{32 . 23}}.
	effectToDistrubute
		with: effectDistributionFields
		do:
			[ :effect :effectFields | self establish: effect on: effectFields ]
]

{ #category : #acccessing }
DeterministicBoard >> numberOfFields [
	 ^numberOfFields.
]

{ #category : #initialize }
DeterministicBoard >> searchFieldFor: aPosition [
	^ fields at: aPosition field.
]
