Class {
	#name : #DeterministicBoard,
	#superclass : #Board,
	#instVars : [
		'fields',
		'numberOfFields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialize }
DeterministicBoard >> initializeSize: aNumberOfFields [ 
	| wormHoleEffectFields speedUpEffectFields moonWalkEffectFields atomicBombEffectFields |
	numberOfFields := aNumberOfFields .
	fields := OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	
	wormHoleEffectFields:= {3 . 17}.
	speedUpEffectFields:= { 30 . 48 }.
	atomicBombEffectFields:= { 44 }.
	moonWalkEffectFields:= { 32 . 23 }.
	
	wormHoleEffectFields do: [ :fieldNumber | fields at:fieldNumber put: WormHoleEffect new ].
	speedUpEffectFields do: [ :fieldNumber | fields at:fieldNumber put: SpeedUpEffect new ].
	atomicBombEffectFields do: [ :fieldNumber | fields at:fieldNumber put: AtomicBombEffect new ].
	moonWalkEffectFields do: [ :fieldNumber | fields at:fieldNumber put: (MoonWalkEffect newAt: fieldNumber) ].
	

	
]

{ #category : #initialize }
DeterministicBoard >> lookUpFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #acccessing }
DeterministicBoard >> numberOfFields [
	 ^numberOfFields.
]
