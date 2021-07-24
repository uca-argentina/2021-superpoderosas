Class {
	#name : #Status,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
Status >> findNewValueWhenYouTryAdding: addend with: originalValue [
	self subclassResponsibility.
]

{ #category : #actions }
Status >> isBlocked [
	self subclassResponsibility.
]

{ #category : #actions }
Status >> resetValueWhenActualIs: value [
	self subclassResponsibility.
	
]
