package com.example.photoshare;

import java.util.Date;

public class Photo {
    private String fileName;
    private String user;
    private Date uploadDate;
    private String visibility;
    private String title;

    public Photo(String fileName, String user, Date uploadDate, String visibility, String title) {
        this.fileName = fileName;
        this.user = user;
        this.uploadDate = uploadDate;
        this.visibility = visibility;
        this.title = title;
    }

    public String getFileName() { return fileName; }
    public String getUser() { return user; }
    public Date getUploadDate() { return uploadDate; }
    public String getVisibility() { return visibility; }
    public String getTitle() { return title; }
}
