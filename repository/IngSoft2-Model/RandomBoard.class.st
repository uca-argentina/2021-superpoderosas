Class {
	#name : #RandomBoard,
	#superclass : #Board,
	#instVars : [
		'numberOfFields',
		'fields'
	],
	#category : #'IngSoft2-Model'
}

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
	| wormHoleEffectFields speedUpEffectFields moonWalkEffectFields atomicBombEffectFields wormHoleEffectAmountOfFields speedUpEffectAmountOfFields atomicBombEffectAmountOfFields moonWalkEffectAmountOfFields fieldsToBeSelected |
	numberOfFields := aNumberOfFields .
	fields := OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	
	fieldsToBeSelected:= OrderedCollection new.
	1 to: numberOfFields do:[:field | fieldsToBeSelected add: field].
	
	wormHoleEffectFields:= OrderedCollection new.
	speedUpEffectFields:= OrderedCollection new.
	atomicBombEffectFields:= OrderedCollection new.
	moonWalkEffectFields:= OrderedCollection new.
	
	wormHoleEffectAmountOfFields:= ((aNumberOfFields) * 0.2) asInteger .
	speedUpEffectAmountOfFields:= ((aNumberOfFields) * 0.2) asInteger.
	atomicBombEffectAmountOfFields:= ((aNumberOfFields) * 0.02) asInteger.
	moonWalkEffectAmountOfFields:= ((aNumberOfFields) * 0.1) asInteger.
	
	1 to: wormHoleEffectAmountOfFields do:[:field | self addRandomFieldTo: wormHoleEffectFields from: fieldsToBeSelected ].
	1 to: speedUpEffectAmountOfFields do:[:field | self addRandomFieldTo: speedUpEffectFields from: fieldsToBeSelected].
	1 to: atomicBombEffectAmountOfFields do:[:field | self addRandomFieldTo: atomicBombEffectFields from: fieldsToBeSelected].
	1 to: moonWalkEffectAmountOfFields do:[:field | self addRandomFieldTo: moonWalkEffectFields from: fieldsToBeSelected].
		
	wormHoleEffectFields do: [ :fieldNumber | fields at:fieldNumber put: WormHoleEffect new ].
	speedUpEffectFields do: [ :fieldNumber | fields at:fieldNumber put: SpeedUpEffect new ].
	atomicBombEffectFields do: [ :fieldNumber | fields at:fieldNumber put: AtomicBombEffect new ].
	moonWalkEffectFields do: [ :fieldNumber | fields at:fieldNumber put: (MoonWalkEffect newAt: fieldNumber) ].
	
	

	
]

{ #category : #initialize }
RandomBoard >> lookUpFieldFor: aPosition [
	^ fields at: aPosition field
]

{ #category : #acccessing }
RandomBoard >> numberOfFields [
	 ^numberOfFields.
]
