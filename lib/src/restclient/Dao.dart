abstract class Dao {
  //layoutEngine/template/{URI}
  getLayout(String uri);
  findById(String className, num id);
  deleteById(String className, num id);
  //className}/find?params
  //className}/find/page/maxresults?params?params
  findByPropertyKey(String className, {num page : 0, num maxresults: 50});
  //className}/findunique?params
  findByPropertyKeyUnique(String className);
  //save
  save(Map model);
  //savelist
  saveList(List<Map> models);


}