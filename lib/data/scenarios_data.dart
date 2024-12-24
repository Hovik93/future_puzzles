import 'package:future_puzzles/base/images.dart';

Map<String, dynamic> scenariosData = {
  "scenarios": [
    {
      "title": "Life on Mars",
      "image": AppImages.scenarios1,
      "description":
          "In 2100, humans successfully colonize Mars. The first Martian colonies are built using local materials and the latest technologies to create sustainable ecosystems. Colonists live in special biodomes, grow food in low gravity, and generate energy with solar panels and fusion reactors.",
      "content": {
        "article": {
          "title":
              "How Humans Could Colonize Mars: Technologies and Challenges",
          "image": AppImages.articleScenario1,
          "content":
              "The colonization of Mars presents unprecedented challenges. Scientists are focusing on technologies such as space habitats, radiation protection, and food production systems to make life possible on the Red Planet. To build a sustainable ecosystem, we must rely on local resources (like regolith and ice) and advanced bioengineering to create air and water cycles within closed habitats. Moreover, advanced propulsion systems will reduce travel time, making Mars more accessible. The future could see human colonies that are self-sustaining and thriving in this hostile environment."
        },
        "puzzle": {
          "title": "What Would Martian Cities Look Like 100 Years from Now?",
          "image": AppImages.quizScenario1,
          "quizzes": [
            {
              "title": "",
              "description":
                  "What materials are most likely to be used to build structures on Mars?",
              "options": [
                "A: Regolith-based concrete",
                "B: Wood and metal",
                "C: Ice and glass",
                "D: Plastic and rubber"
              ],
              "correct_answer": "A"
            },
            {
              "title": "",
              "description":
                  "What is the most likely source of energy for Martian cities?",
              "options": [
                "A: Solar panels",
                "B: Coal power",
                "C: Geothermal energy",
                "D: Wind turbines"
              ],
              "correct_answer": "A"
            }
          ]
        }
      },
      "points_required": 500
    },
    {
      "title": "AI Guided by Humans",
      "image": AppImages.scenarios2,
      "description":
          "In 2050, artificial intelligence learns to work alongside humans, helping in decision-making without fully replacing them. AI systems are actively used in city management, healthcare, justice, and education. These AI systems become companions in everyday life, assisting people in organizing their activities.",
      "content": {
        "article": {
          "title": "AI and Humans: How Working Together Will Change Society",
          "image": AppImages.articleScenario2,
          "content":
              "By 2050, AI will not replace humans but rather augment their abilities. This collaboration will lead to a new kind of workforce, where humans focus on creative and emotional intelligence, while AI handles repetitive tasks. In sectors such as healthcare, AI can help doctors by analyzing vast amounts of medical data and predicting outcomes, while humans make the final decisions. In education, AI tutors will adapt to the needs of each student, providing personalized learning experiences. This partnership will redefine what it means to work and live in a world where AI and humans are equals."
        },
        "puzzle": {
          "title": "How Will AI Be Used in Everyday Life in 2050?",
          "image": AppImages.quizScenario2,
          "quizzes": [
            {
              "title": "",
              "description":
                  "Which of the following tasks could AI handle in daily life?",
              "options": [
                "A: Personal assistants for scheduling",
                "B: Emotion-based therapy",
                "C: Creating new scientific theories",
                "D: Reading literature and writing poetry"
              ],
              "correct_answer": "A"
            },
            {
              "title": "",
              "description": "What role will AI play in education?",
              "options": [
                "A: Managing student behavior",
                "B: Providing personalized tutoring",
                "C: Designing the school curriculum",
                "D: Marking student assignments"
              ],
              "correct_answer": "B"
            }
          ]
        }
      },
      "points_required": 1000
    }
  ]
};
