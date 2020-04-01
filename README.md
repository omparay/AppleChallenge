AppleChallenge

This challenge was somewhat similar to the challenge given to me by Krikey which is on https://github.com/omparay/KrikeyChallenge but there were some major differences...

1 The fields required to display are different in the AppleChallenge
  - Name
  - Artwork
  - Genre
  - URL
  
2 The KrikeyChallenge had an expectation of animations (transitions) from screen to screen which is not required in AppleChallenge

3 The AppleChallenge has an expectation for maintaining a persistence of items marked as favorites which was not needed in the KrikeyChallenge

Despite the differences both apps share one overriding feature: they both access the iTunes Search API.

This was advantageous to me since I had written up an iTunesSearch client within the Library files I had written for KrikeyChallenge. I did not have to write-up the client from scratch.

But there were enough new features for me to implement:

- A new UI (IMHO a simpler and better one)
- A persistence feature
- Different fields to decode from the iTunes Search API JSON

All-in-all it took about 8 hours of on-and-off again work

I kept the MVC pattern as it was quick although VIPER would be the better pattern even though it normally takes longer to develop for. Also testing for performance led me to put the image downloading code on each instance of the UITableViewCell.

Code was tested on iOS Simulator, iPhone 11 Pro Max and iPad Pro 13 (Gen 1)
