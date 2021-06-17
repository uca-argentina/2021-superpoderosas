Class {
	#name : #Instantaneous,
	#superclass : #Card,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Instantaneous >> apply: arg1 at: arg2 [ 
	^ self subclassResponsibility
]

{ #category : #actions }
Instantaneous >> do: arg1 at: arg2 [ 
	^ self subclassResponsibility
]
