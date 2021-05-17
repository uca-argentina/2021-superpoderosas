Class {
	#name : #Board,
	#superclass : #Object,
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Board class >> size: aNumberOfFields [ 
	^ self new initializeSize: aNumberOfFields .
]

{ #category : #initialize }
Board >> applyTheEffectOn: playersPosition determinedBy: aPosition onABoardWith: aNumberOfFields [
	(self lookUpFieldFor: aPosition)
		applyTheEffectOn: playersPosition
		determinedBy: aPosition
		onABoardWith: aNumberOfFields
]

{ #category : #initialize }
Board >> lookUpFieldFor: aPosition [
	self subclassResponsibility.
]

{ #category : #initialize }
Board >> numberOfFields [
	self subclassResponsibility.
]
