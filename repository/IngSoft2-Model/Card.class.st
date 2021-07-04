Class {
	#name : #Card,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Card >> thrownBy: arg1 aims: arg2 on: arg3 handledBy: arg4 [ 
	^ self subclassResponsibility
]
