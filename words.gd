extends Node


var words = [
"the", "of", "and", "a", "to", "in", "is", "you", "that", "it", "he", "was", "for", "on", "are", "with", "as", "his", "they", "I", "at", "be", "this", "have", "from", "or", "one", "had", "by", "word", "but", "not", "what", "all", "were", "we", "when", "their", "use", "which", "said", "she", "make", "an", "each", "how", "about", "who", "get", "would", "there", "their", "we", "down", "only", "up", "so", "love", "water", "time", "more", "year", "day", "good", "man", "world", "about", "life", "then", "into", "than", "children", "work", "well", "thought", "think", "say", "give", "child", "God", "mother", "other", "father", "know", "way", "two", "many", "number", "new", "house", "use", "land", "people", "out", "little", "year", "day", "night", "life", "walk", "take", "over", "into", "just", "young", "small", "white", "round", "green", "red", "black", "gray", "blue", "brown", "yellow", "light", "dark", "hot", "cold", "wet", "dry", "soft", "hard", "long", "short", "big", "small", "heavy", "light", "clean", "dirty", "funny", "sad", "happy", "angry", "tired", "awake", "alive", "dead", "true", "false", "good", "bad", "pretty", "ugly", "quick", "slow", "easy", "hard", "near", "far", "high", "low", "full", "empty", "more", "most", "less", "least", "right", "wrong", "same", "different", "good", "bad", "better", "best", "worse", "worst", "first", "last", "both", "none", "all", "any", "some", "which", "this", "that", "I", "you", "he", "she", "it", "we", "they", "am", "are", "is", "be", "was", "were", "will", "have", "has", "had", "do", "does", "did", "say", "says", "said", "can", "could", "shall", "should", "may", "might", "must", "would", "like", "don't", "not", "no", "now", "then", "so", "too", "very", "just", "because", "but", "if", "or", "unless", "while", "although", "when", "until", "before", "after", "because", "for", "since", "till", "as", "like", "same", "also", "too", "even", "so", "only", "just", "now", "then", "here", "there", "everywhere", "now", "then", "soon", "late", "early", "always", "never", "sometimes", "often", "rarely", "yes", "no", "maybe", "perhaps", "I don't know", "up", "down", "in", "out", "on", "off", "over", "under", "above", "below", "around", "through", "near", "far", "left", "right", "front", "back", "together", "apart", "inside", "outside", "here", "there", "everywhere", "now", "then", "soon", "late", "early", "always", "never", "sometimes", "often", "rarely", "big", "small", "tall", "short", "wide", "narrow", "thick", "thin", "long", "short", "heavy", "light", "hot", "cold", "wet", "dry", "clean", "dirty", "funny", "sad", "happy", "angry", "tired", "awake", "alive", "dead", "true", "false", "good", "bad", "pretty", "ugly", "quick", "slow", "easy", "hard", "near", "far", "high", "low",
]

func choose_word() -> String:
	var word_index = randi() % words.size()
	print(word_index)
	var word = words[word_index]
	print(word)
	return word
