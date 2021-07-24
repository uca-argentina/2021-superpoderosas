Class {
	#name : #ActiveCondition,
	#superclass : #Status,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
ActiveCondition >> findNewValueWhenYouTryAdding: addend with: originalValue [
	^addend + originalValue.
]

{ #category : #actions }
ActiveCondition >> isBlocked [
	^false.
]

{ #category : #actions }
ActiveCondition >> resetValueWhenActualIs: value [
	^1.
]
