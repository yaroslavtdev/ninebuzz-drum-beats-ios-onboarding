# DrumBeatsOnboarding

DrumBeatsOnboarding is a Swift Package Manager (SPM) module designed for the DrumBeats iOS app. This module enables an interactive and customizable onboarding flow using SwiftUI, which can be configured with a local `survey.json` file or remotely through Firebase Remote Config.

## Features

- Swift Package Manager (SPM) compatible.
- Built with SwiftUI for a fully native iOS experience.
- Supports local testing using a provided `survey.json` file.
- Remote configuration via Firebase Remote Config, allowing dynamic updates to the onboarding flow.
- Easily customizable sequences, questions, and content using JSON.

## Requirements

- iOS 15.0 or later
- Swift 5 or later
- Firebase for Remote Config (optional for dynamic remote configuration)

## Installation

To add DrumBeatsOnboarding as a dependency to your project, use Swift Package Manager.

1. Open Xcode and go to **File > Swift Packages > Add Package Dependency...**
2. Enter the repository URL: `git@bitbucket.org:ninebuzz/drum-beats-ios-onboarding.git` !! Ensure that you are using ssh.
3. Choose the master branch, and complete the setup.

## Usage

### Local Testing

To test the onboarding flow locally:

1. Add a `survey.json` file to your project. This JSON file defines the sequence of screens, questions, and some content.
2. Run the app, and the onboarding flow will follow the structure defined in `survey.json`.

### Remote Configuration

To enable dynamic updates to the onboarding flow:

1. Integrate Firebase into your main repository and enable Remote Config.
2. Fetch the JSON configuration from Firebase and supply to the Onboarding. This will allow you to adjust the onboarding sequence and content without requiring an app update. Fetching 

The module will prioritize the configuration in this order defined in the main repository. For ex:
1. Remote configuration from Firebase (if available).
2. Local `survey.json` (if provided).

### JSON Structure

The JSON file used for configuration should follow this structure:

```json
{
  "version": "002",
  "screens": [
    {
      "type": "question",
        "question": {
          "tag": "top-motivation",
          "allowsMultipleSelection": true,
          "title": "What’s your top motivation?",
          "subtitle": "Select all that apply",
          "required": true,
          "autoAdvanceOnChoice": false,
          "choices": [
            {
              "uuid": "5601E171-12E2-4D12-94C1-938C9656EC46",
              "selected": false,
              "allowsCustomTextEntry": false,
              "text": "Improve my rhythm and timing",
              "tag": "Improve my rhythm and timing",
            },
            {
              "uuid": "ED20D030-40DA-4CE5-8E3B-E105DC9B5570",
              "selected": false,
              "allowsCustomTextEntry": false,
              "text": "Creative inspiration",
              "tag": "Creative inspiration"
            },
            {
              "uuid": "FA510E06-97D1-4AF6-9AA3-7CC670D45CF4",
              "selected": false,
              "allowsCustomTextEntry": false,
              "text": "Prepare for a gig",
              "tag": "Prepare for a gig"
            },
            {
              "uuid": "783083FF-8D1A-4545-88FD-5C95B6AFCFE3",
              "selected": false,
              "allowsCustomTextEntry": false,
              "text": "Experiment and have fun",
              "tag": "Experiment and have fun"
            },
            {
              "uuid": "DE786745-468E-4261-BED0-914F855E1116",
              "selected": false,
              "allowsCustomTextEntry": false,
              "text": "Learn to play with a drummer",
              "tag": "Learn to play with a drummer"
            },
            {
              "uuid": "2836EA95-2446-4E79-9469-2A8BDBF4A90F",
              "selected": false,
              "allowsCustomTextEntry": false,
              "text": "Replace my boring metronome",
              "tag": "Replace my boring metronome"
            }
          ],
          "uuid": "0F47E8F9-C7FB-47D0-BEDD-3A7D964A3A38"
        }
     }
   ]
}
```
