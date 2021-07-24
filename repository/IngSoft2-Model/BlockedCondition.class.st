Class {
	#name : #BlockedCondition,
	#superclass : #Status,
	#category : #'IngSoft2-Model'
}

{ #category : #actions }
BlockedCondition >> findNewValueWhenYouTryAdding: addend with: originalValue [
	^originalValue.
]

{ #category : #actions }
BlockedCondition >> isBlocked [
	 ^true.
]

{ #category : #actions }
BlockedCondition >> resetValueWhenActualIs: value [
	^value.
]
