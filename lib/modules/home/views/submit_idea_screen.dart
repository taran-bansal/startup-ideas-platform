import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/custom_app_bar.dart';
import '../../../widgets/custom_text_field.dart';
import '../controllers/submit_idea_controller.dart';

class SubmitIdeaScreen extends GetView<SubmitIdeaController> {
  const SubmitIdeaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Submit Idea',
        showBackButton: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextField(
                    label: 'Startup Name',
                    hintText: 'Enter startup name',
                    onChanged: controller.setTitle,
                    isRequired: true,
                    initialValue: controller.title.value,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextField(
                    label: 'Tagline',
                    hintText: 'Enter a short tagline',
                    onChanged: controller.setTagline,
                    isRequired: true,
                    initialValue: controller.tagline.value,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextField(
                    label: 'Description',
                    hintText: 'Describe your startup idea in detail',
                    onChanged: controller.setDescription,
                    isRequired: true,
                    maxLines: 5,
                    minLines: 3,
                    initialValue: controller.description.value,
                  ),
                ),
                const SizedBox(height: 16),
                Obx(
                  () => CustomTextField(
                    label: 'Image URL (Optional)',
                    hintText: 'https://example.com/image.jpg',
                    onChanged: controller.setImageUrl,
                    keyboardType: TextInputType.url,
                    initialValue: controller.imageUrl.value,
                  ),
                ),
                const SizedBox(height: 32),
                Obx(() {
                  return ElevatedButton(
                    onPressed: controller.isFormValid && !controller.isSubmitting.value
                        ? () => controller.submitIdea()
                        : null,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isSubmitting.value
                        ? const SizedBox(
                            height: 24,
                            width: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Submit Idea',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  );
                }),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
