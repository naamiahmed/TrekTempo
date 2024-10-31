import 'package:flutter/material.dart';

class FeedbackSupportPage extends StatelessWidget {
  const FeedbackSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback & Support'),
        backgroundColor: Colors.teal, // Custom AppBar color
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Section for User Feedback
            const Text(
              'We value your feedback!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10), // Spacing
            const Text(
              'Your thoughts help us improve. Please let us know what you think or report any issues you have experienced.',
              style: TextStyle(fontSize: 16, height: 1.5),
              textAlign: TextAlign.justify,
            ),
            const SizedBox(height: 20), // Spacing

            // Feedback Text Field
            const TextField(
              maxLines: 5,
              decoration: InputDecoration(
                labelText: 'Your Feedback',
                border: OutlineInputBorder(),
                hintText: 'Type your feedback here...',
              ),
            ),
            const SizedBox(height: 20), // Spacing
            
            // Submit Button
            ElevatedButton(
              onPressed: () {
                // Logic to handle feedback submission
                // For now, just show a snackbar
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Feedback submitted! Thank you!')),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text('Submit Feedback'),
            ),
            
            const SizedBox(height: 30), // Spacing
            
            // FAQs Section
            const Text(
              'Frequently Asked Questions (FAQs)',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10), // Spacing
            
            buildFAQItem(
              question: 'How do I create a personalized itinerary?',
              answer: 'You can create a personalized itinerary by selecting your preferred destinations and activities in the app.',
            ),
            buildFAQItem(
              question: 'What should I do in case of an emergency?',
              answer: 'Please refer to the Emergency Hotlines section in the app for immediate assistance.',
            ),
            buildFAQItem(
              question: 'How can I provide feedback?',
              answer: 'You can provide feedback in the Feedback section of the app.',
            ),
            // Add more FAQs as needed
          ],
        ),
      ),
    );
  }

  // Helper widget for building FAQ items
  Widget buildFAQItem({required String question, required String answer}) {
    return ExpansionTile(
      title: Text(
        question,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            answer,
            style: const TextStyle(fontSize: 14),
          ),
        ),
      ],
    );
  }
}
