package hcmcore.tenants.jobtitles;

import com.intuit.karate.junit5.Karate;

class JobTitlesRunner {
    
    @Karate.Test
    Karate testUsers() {
        return new Karate().feature("get-job-title").relativeTo(getClass());
    }    

}
