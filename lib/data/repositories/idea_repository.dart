import 'package:get/get.dart';
import '../models/idea_model.dart';

abstract class IdeaRepository {
  Future<List<IdeaModel>> getIdeas({String? sortBy, bool ascending = false});
  Future<IdeaModel> getIdea(String id);
  Future<String> createIdea(IdeaModel idea);
  Future<void> updateIdea(IdeaModel idea);
  Future<void> deleteIdea(String id);
  Future<void> voteIdea(String ideaId, String userId, {required bool upvote});
  Future<List<IdeaModel>> searchIdeas(String query);
}

class MockIdeaRepository extends GetxService implements IdeaRepository {
  final List<IdeaModel> _ideas = [
    IdeaModel(
      id: '1',
      title: 'Scootify',
      tagline: 'Eco-friendly urban mobility',
      description: 'Revolutionizing urban mobility with eco-friendly scooters.',
      imageUrl: 'https://example.com/scootify.jpg',
      rating: 4.9,
      votes: 125,
      authorId: 'user1',
    ),
    IdeaModel(
      id: '2',
      title: 'FitAI',
      tagline: 'AI-powered fitness',
      description: 'Personalized fitness plans with AI-driven insights.',
      imageUrl: 'https://example.com/fitai.jpg',
      rating: 4.8,
      votes: 118,
      authorId: 'user2',
    ),
    IdeaModel(
      id: '3',
      title: 'ArtisanConnect',
      tagline: 'Handmade marketplace',
      description: 'Connecting local artisans with global buyers.',
      imageUrl: 'https://example.com/artisan.jpg',
      rating: 4.7,
      votes: 112,
      authorId: 'user3',
    ),
    IdeaModel(
      id: '4',
      title: 'EcoChic',
      tagline: 'Sustainable fashion',
      description: 'Sustainable fashion marketplace for pre-owned clothing.',
      imageUrl: 'https://example.com/ecochic.jpg',
      rating: 4.6,
      votes: 105,
      authorId: 'user4',
    ),
  ];

  @override
  Future<List<IdeaModel>> getIdeas({String? sortBy, bool ascending = false}) async {
    await Future.delayed(const Duration(milliseconds: 500));
    
    List<IdeaModel> sortedIdeas = List.from(_ideas);
    
    if (sortBy != null) {
      switch (sortBy.toLowerCase()) {
        case 'rating':
          sortedIdeas.sort((a, b) => a.rating.compareTo(b.rating));
          break;
        case 'votes':
          sortedIdeas.sort((a, b) => a.votes.compareTo(b.votes));
          break;
        case 'date':
          sortedIdeas.sort((a, b) => a.createdAt.compareTo(b.createdAt));
          break;
        default:
          break;
      }
      
      if (!ascending) {
        sortedIdeas = sortedIdeas.reversed.toList();
      }
    }
    
    return sortedIdeas;
  }

  @override
  Future<IdeaModel> getIdea(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _ideas.firstWhere((idea) => idea.id == id);
  }

  @override
  Future<String> createIdea(IdeaModel idea) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final newIdea = idea.copyWith(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      createdAt: DateTime.now(),
    );
    _ideas.add(newIdea);
    return newIdea.id;
  }

  @override
  Future<void> updateIdea(IdeaModel idea) async {
    await Future.delayed(const Duration(milliseconds: 400));
    final index = _ideas.indexWhere((i) => i.id == idea.id);
    if (index != -1) {
      _ideas[index] = idea;
    }
  }

  @override
  Future<void> deleteIdea(String id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _ideas.removeWhere((idea) => idea.id == id);
  }

  @override
  Future<void> voteIdea(String ideaId, String userId, {required bool upvote}) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final index = _ideas.indexWhere((idea) => idea.id == ideaId);
    if (index != -1) {
      final idea = _ideas[index];
      final newVotes = upvote ? idea.votes + 1 : idea.votes - 1;
      _ideas[index] = idea.copyWith(
        votes: newVotes,
        rating: (idea.rating * idea.votes + (upvote ? 1 : -1)) / (newVotes > 0 ? newVotes : 1),
      );
    }
  }

  @override
  Future<List<IdeaModel>> searchIdeas(String query) async {
    await Future.delayed(const Duration(milliseconds: 300));
    if (query.isEmpty) return [];
    final lowercaseQuery = query.toLowerCase();
    return _ideas.where((idea) {
      return idea.title.toLowerCase().contains(lowercaseQuery) ||
          idea.tagline.toLowerCase().contains(lowercaseQuery) ||
          idea.description.toLowerCase().contains(lowercaseQuery);
    }).toList();
  }
}
