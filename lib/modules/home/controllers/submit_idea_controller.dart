import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/controllers/base_controller.dart';
import '../../../data/models/idea_model.dart';
import '../../../data/repositories/idea_repository.dart';

class SubmitIdeaController extends BaseController {
  final IdeaRepository _repository;
  
  SubmitIdeaController(this._repository);

  final RxString title = ''.obs;
  final RxString tagline = ''.obs;
  final RxString description = ''.obs;
  final RxString imageUrl = ''.obs;
  
  final RxBool isSubmitting = false.obs;
  final RxBool isSuccess = false.obs;
  
  void setTitle(String value) => title.value = value;
  void setTagline(String value) => tagline.value = value;
  void setDescription(String value) => description.value = value;
  void setImageUrl(String value) => imageUrl.value = value;
  
  bool get isFormValid => 
      title.value.isNotEmpty && 
      tagline.value.isNotEmpty && 
      description.value.isNotEmpty;
  
  Future<void> submitIdea() async {
    if (!isFormValid) return;
    
    try {
      isSubmitting.value = true;
      isSuccess.value = false;
      
      final idea = IdeaModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title.value,
        tagline: tagline.value,
        description: description.value,
        imageUrl: imageUrl.value.isNotEmpty ? imageUrl.value : null,
        rating: 0.0,
        votes: 0,
        authorId: 'current_user_id', // Replace with actual user ID from auth
        createdAt: DateTime.now(),
      );
      
      await _repository.createIdea(idea);
      
      // Reset form
      title.value = '';
      tagline.value = '';
      description.value = '';
      imageUrl.value = '';
      
      isSuccess.value = true;
      Get.snackbar(
        'Success',
        'Idea submitted successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      // Navigate back
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit idea. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      rethrow;
    } finally {
      isSubmitting.value = false;
    }
  }
  
  void resetForm() {
    title.value = '';
    tagline.value = '';
    description.value = '';
    imageUrl.value = '';
    isSuccess.value = false;
  }
  
  @override
  void onClose() {
    title.close();
    tagline.close();
    description.close();
    imageUrl.close();
    isSubmitting.close();
    isSuccess.close();
    super.onClose();
  }
}
