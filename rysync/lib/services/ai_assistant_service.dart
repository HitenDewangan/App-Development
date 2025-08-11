import '../models/user_model.dart';

enum DateSuggestionType {
  restaurant,
  activity,
  location,
  gift,
  conversation,
}

class DateSuggestion {
  final String title;
  final String description;
  final DateSuggestionType type;
  final String? location;
  final String? priceRange;
  final List<String> tags;

  DateSuggestion({
    required this.title,
    required this.description,
    required this.type,
    this.location,
    this.priceRange,
    this.tags = const [],
  });
}

class AIResponse {
  final String message;
  final List<DateSuggestion>? suggestions;
  final bool isHelpful;

  AIResponse({
    required this.message,
    this.suggestions,
    this.isHelpful = true,
  });
}

class AIAssistantService {
  // In a real app, you would integrate with OpenAI API or similar
  // For now, we'll create a mock service with predefined responses

  final Map<String, List<DateSuggestion>> _dateIdeas = {
    'restaurant': [
      DateSuggestion(
        title: 'Cozy Italian Bistro',
        description: 'A romantic candlelit dinner with authentic Italian cuisine',
        type: DateSuggestionType.restaurant,
        priceRange: '\$\$',
        tags: ['romantic', 'intimate', 'dinner'],
      ),
      DateSuggestion(
        title: 'Rooftop Restaurant',
        description: 'Enjoy city views while dining under the stars',
        type: DateSuggestionType.restaurant,
        priceRange: '\$\$\$',
        tags: ['romantic', 'views', 'special'],
      ),
      DateSuggestion(
        title: 'Food Truck Festival',
        description: 'Casual and fun dining with variety of options',
        type: DateSuggestionType.restaurant,
        priceRange: '\$',
        tags: ['casual', 'fun', 'variety'],
      ),
    ],
    'activity': [
      DateSuggestion(
        title: 'Art Gallery Visit',
        description: 'Explore local art and have meaningful conversations',
        type: DateSuggestionType.activity,
        priceRange: '\$',
        tags: ['cultured', 'conversation', 'artistic'],
      ),
      DateSuggestion(
        title: 'Cooking Class',
        description: 'Learn to cook together - fun and interactive',
        type: DateSuggestionType.activity,
        priceRange: '\$\$',
        tags: ['interactive', 'learning', 'teamwork'],
      ),
      DateSuggestion(
        title: 'Mini Golf',
        description: 'Light-hearted competition with plenty of laughs',
        type: DateSuggestionType.activity,
        priceRange: '\$',
        tags: ['fun', 'competitive', 'casual'],
      ),
    ],
    'location': [
      DateSuggestion(
        title: 'Local Park',
        description: 'Peaceful walk surrounded by nature',
        type: DateSuggestionType.location,
        priceRange: 'Free',
        tags: ['peaceful', 'nature', 'relaxing'],
      ),
      DateSuggestion(
        title: 'Beach or Waterfront',
        description: 'Romantic walk along the water',
        type: DateSuggestionType.location,
        priceRange: 'Free',
        tags: ['romantic', 'scenic', 'relaxing'],
      ),
    ],
  };

  final List<String> _conversationStarters = [
    "What's something that always makes you smile?",
    "If you could travel anywhere right now, where would you go?",
    "What's the most adventurous thing you've ever done?",
    "What's your favorite way to spend a weekend?",
    "What's something you're passionate about that most people don't know?",
    "If you could have dinner with anyone, who would it be?",
    "What's the best advice you've ever received?",
    "What's something you're looking forward to?",
  ];

  // Get personalized date suggestions
  Future<AIResponse> getDateSuggestions({
    required UserModel user,
    String? occasion,
    bool isFirstDate = false,
    String? budget,
    String? preferredActivity,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate API call

    List<DateSuggestion> suggestions = [];
    String message = '';

    if (isFirstDate) {
      message = "For a first date, I recommend something casual and public where you can easily talk and get to know each other.";
      suggestions.addAll(_dateIdeas['activity']!.where((s) => 
        s.tags.contains('casual') || s.tags.contains('conversation')));
    } else if (occasion?.toLowerCase().contains('birthday') == true) {
      message = "For a birthday date, let's make it special and memorable!";
      suggestions.addAll(_dateIdeas['restaurant']!.where((s) => 
        s.tags.contains('special') || s.tags.contains('romantic')));
      suggestions.addAll(_dateIdeas['activity']!.where((s) => 
        s.tags.contains('interactive')));
    } else {
      message = "Here are some great date ideas based on your preferences:";
      suggestions.addAll(_dateIdeas['restaurant']!.take(2));
      suggestions.addAll(_dateIdeas['activity']!.take(2));
    }

    // Filter by budget if specified
    if (budget != null) {
      if (budget.toLowerCase().contains('low') || budget.contains('\$')) {
        suggestions = suggestions.where((s) => 
          s.priceRange == '\$' || s.priceRange == 'Free').toList();
      } else if (budget.toLowerCase().contains('high') || budget.contains('\$\$\$')) {
        suggestions = suggestions.where((s) => 
          s.priceRange == '\$\$\$').toList();
      }
    }

    return AIResponse(
      message: message,
      suggestions: suggestions,
    );
  }

  // Get conversation suggestions
  Future<AIResponse> getConversationSuggestions({
    required UserModel user,
    String? context,
  }) async {
    await Future.delayed(const Duration(milliseconds: 500));

    List<String> suggestions = List.from(_conversationStarters);
    suggestions.shuffle();

    String message = context != null 
        ? "Here are some conversation starters perfect for $context:"
        : "Here are some great conversation starters:";

    return AIResponse(
      message: "$message\n\n${suggestions.take(3).map((s) => "• $s").join('\n')}",
    );
  }

  // Get relationship advice
  Future<AIResponse> getRelationshipAdvice({
    required UserModel user,
    required String question,
  }) async {
    await Future.delayed(const Duration(seconds: 1));

    Map<String, String> responses = {
      'nervous': "It's completely normal to feel nervous! Take deep breaths, be yourself, and remember that your date is probably just as nervous. Focus on having a genuine conversation and getting to know each other.",
      'what to wear': "Dress appropriately for the venue and activity. When in doubt, smart casual is usually a safe choice. Most importantly, wear something that makes you feel confident and comfortable.",
      'first date': "Keep it light and fun! Ask open-ended questions, listen actively, and share about yourself too. Avoid controversial topics and focus on finding common interests.",
      'second date': "Great! The fact that there's a second date means things went well. You can be a bit more personal now, maybe try a different type of activity, and continue building that connection.",
      'gift': "For early dating, keep gifts simple and thoughtful rather than expensive. Consider their interests - maybe a book they mentioned, flowers, or something small that shows you were listening.",
    };

    String response = "I'd be happy to help! ";
    
    String lowerQuestion = question.toLowerCase();
    for (String key in responses.keys) {
      if (lowerQuestion.contains(key)) {
        response += responses[key]!;
        break;
      }
    }

    if (response == "I'd be happy to help! ") {
      response += "That's an interesting question! Remember that every relationship is unique. Focus on being authentic, communicating openly, and treating your partner with respect and kindness.";
    }

    return AIResponse(message: response);
  }

  // Analyze user behavior and provide insights
  Future<AIResponse> getUserInsights(UserModel user) async {
    await Future.delayed(const Duration(milliseconds: 800));

    List<String> insights = [];

    if (user.interests.isEmpty) {
      insights.add("Consider adding more interests to your profile to help find better matches!");
    }

    if (user.photos.length < 3) {
      insights.add("Adding more photos to your profile can increase your match potential by up to 40%!");
    }

    if (user.bio == null || user.bio!.length < 50) {
      insights.add("A detailed bio helps others understand your personality better. Try writing a bit more about yourself!");
    }

    if (insights.isEmpty) {
      insights.add("Your profile looks great! You're doing well at presenting yourself authentically.");
    }

    return AIResponse(
      message: "Profile Insights:\n\n${insights.map((i) => "• $i").join('\n')}",
    );
  }

  // Get location-specific suggestions
  Future<AIResponse> getLocationSuggestions({
    required String city,
    required DateSuggestionType type,
  }) async {
    await Future.delayed(const Duration(milliseconds: 600));

    // In a real app, this would use Google Places API or similar
    return AIResponse(
      message: "Here are some popular ${type.name} spots in $city. I recommend checking reviews and making reservations in advance for the best experience!",
      suggestions: _dateIdeas[type.name] ?? [],
    );
  }

  // Save user conversation for learning
  Future<void> saveUserInteraction({
    required String userId,
    required String question,
    required String response,
    required bool wasHelpful,
  }) async {
    // In a real app, this would save to a database for improving AI responses
    // For now, we'll just simulate the save
    await Future.delayed(const Duration(milliseconds: 200));
  }

  // Get daily dating tip
  Future<AIResponse> getDailyTip() async {
    List<String> tips = [
      "Smile genuinely - it's one of the most attractive qualities you can have!",
      "Ask follow-up questions to show you're genuinely interested in what they're saying.",
      "Be present - put your phone away and focus on your date.",
      "Share something personal but not too intimate - vulnerability builds connection.",
      "Remember that dating should be fun - don't put too much pressure on yourself!",
      "Good hygiene and grooming show respect for yourself and your date.",
      "Plan a backup activity in case your original plan falls through.",
      "Listen more than you talk - people love feeling heard and understood.",
    ];

    tips.shuffle();
    return AIResponse(message: "💡 Today's Dating Tip: ${tips.first}");
  }
}
