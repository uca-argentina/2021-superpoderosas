Class {
	#name : #RandomBoard,
	#superclass : #Board,
	#instVars : [
		'numberOfFields',
		'fields'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
RandomBoard >> amountOfFieldsWith: aClass [ 
	^(fields select:[:field | field class == aClass ]) size .
]

{ #category : #initialize }
RandomBoard >> initializeSize: aNumberOfFields [ 
	| wormHoleEffectFields speedUpEffectFields moonWalkEffectFields atomicBombEffectFields wormHoleEffectAmountOfFields speedUpEffectAmountOfFields atomicBombEffectAmountOfFields moonWalkEffectAmountOfFields fieldsToBeSelected aRandomField |
	numberOfFields := aNumberOfFields .
	fields := OrderedCollection new: aNumberOfFields withAll: NoEffect new.
	
	wormHoleEffectFields:= OrderedCollection new.
	speedUpEffectFields:= OrderedCollection new.
	atomicBombEffectFields:= OrderedCollection new.
	moonWalkEffectFields:= OrderedCollection new.
	
	fieldsToBeSelected:= OrderedCollection new.
	1 to: numberOfFields do:[:field | fieldsToBeSelected add: field].
	
	wormHoleEffectAmountOfFields:= ((aNumberOfFields) * 0.2) asInteger .
	speedUpEffectAmountOfFields:= ((aNumberOfFields) * 0.2) asInteger.
	atomicBombEffectAmountOfFields:= ((aNumberOfFields) * 0.02) asInteger.
	moonWalkEffectAmountOfFields:= ((aNumberOfFields) * 0.1) asInteger.
	
	"refactor con un extract mthod"
	1 to: wormHoleEffectAmountOfFields do:[:field | aRandomField:= fieldsToBeSelected atRandom . wormHoleEffectFields add: aRandomField. fieldsToBeSelected remove: aRandomField].
	1 to: speedUpEffectAmountOfFields do:[:field | aRandomField:= fieldsToBeSelected atRandom . speedUpEffectFields add: aRandomField. fieldsToBeSelected remove: aRandomField].
	1 to: atomicBombEffectAmountOfFields do:[:field | aRandomField:= fieldsToBeSelected atRandom . atomicBombEffectFields add: aRandomField. fieldsToBeSelected remove: aRandomField].
	1 to: moonWalkEffectAmountOfFields do:[:field | aRandomField:= fieldsToBeSelected atRandom . moonWalkEffectFields add: aRandomField. fieldsToBeSelected remove: aRandomField].
		
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
