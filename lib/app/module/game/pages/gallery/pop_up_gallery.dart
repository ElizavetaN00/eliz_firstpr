class Facts {
  String getNameOfFacts(int index) {
    return 'assets/images/facts/pop-up_facts_ask_$index';
  }

  getLockFacts(int index) {
    return getNameOfFacts(index) + '_on.png';
  }

  getPopUpFact(int index) {
    return getNameOfFacts(index) + '_open.png';
  }

  getOpenFact(int index) {
    return getNameOfFacts(index) + '.png';
  }

  var factsId = List.generate(10, (index) => index + 1);
}
