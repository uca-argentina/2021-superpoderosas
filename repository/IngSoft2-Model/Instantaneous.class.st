Class {
	#name : #Instantaneous,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Instantaneous >> apply: aMove at: aBoardGame [
	^ self subclassResponsibility
]

{ #category : #actions }
Instantaneous >> do: aMove at: aBoardGame [
	^ self subclassResponsibility
]
