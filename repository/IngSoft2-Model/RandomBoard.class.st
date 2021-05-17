Class {
	#name : #RandomBoard,
	#superclass : #Board,
	#instVars : [
		'numberOfFields',
		'fields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
RandomBoard >> add: effect aCertain: numberOfTimes from: fieldsToBeSelected onABoardWith: aNumberOfFields [
	| effectAmountOfFields effectFields |
	effectFields := OrderedCollection new.
	effectAmountOfFields := (aNumberOfFields * numberOfTimes) asInteger.
	1 to: effectAmountOfFields do: [ :field | self addRandomFieldTo: effectFields from: fieldsToBeSelected ].
	^ effectFields do: [ :fieldNumber | fields at: fieldNumber put: effect ]
]

{ #category : #acccessing }
RandomBoard >> addRandomFieldTo: aCollection from: anotherCollection [ 
	| aRandomField |
	aRandomField:= anotherCollection atRandom . 
	aCollection add: aRandomField. 
	anotherCollection remove: aRandomField
]

{ #category : #accessing }
RandomBoard >> amountOfFieldsWith: aClass [ 
	^(fields select:[:field | field class == aClass ]) size .
]

{ #category : #initialize }
RandomBoard >> initializeSize: aNumberOfFields [
	| fieldsToBeSelected effectDistributionProportion effectToDistrubute |
	numberOfFields := aNumberOfFields.
	fields := OrderedCollection
		new: aNumberOfFields
		withAll: NoEffect new.
	fieldsToBeSelected := OrderedCollection new.
	1 to: numberOfFields do: [ :field | fieldsToBeSelected add: field ].
	effectToDistrubute := {WormHoleEffect new.
	SpeedUpEffect new.
	AtomicBombEffect new.
	MoonWalkEffect new}.
	effectDistributionProportion := {0.2 . 0.2 . 0.02 . 0.1}.
	effectToDistrubute
		with: effectDistributionProportion
		do: [ :effect :numberOfTimes | self add: effect aCertain: numberOfTimes from: fieldsToBeSelected onABoardWith: aNumberOfFields ]
]

{ #category : #initialize }
RandomBoard >> lookUpFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #acccessing }
RandomBoard >> numberOfFields [
	 ^numberOfFields.
]
