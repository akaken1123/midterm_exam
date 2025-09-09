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

    // Getter / Setter
    public String getFileName() { return fileName; }
    public void setFileName(String fileName) { this.fileName = fileName; }

    public String getUser() { return user; }
    public void setUser(String user) { this.user = user; }

    public Date getUploadDate() { return uploadDate; }
    public void setUploadDate(Date uploadDate) { this.uploadDate = uploadDate; }

    public String getVisibility() { return visibility; }
    public void setVisibility(String visibility) { this.visibility = visibility; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
}
