package com.nian.bean;

public class Category {
    public Category(Integer cateId, String cateName) {
		super();
		this.cateId = cateId;
		this.cateName = cateName;
	}

	public Category() {
		super();
		// TODO Auto-generated constructor stub
	}

	private Integer cateId;

    private String cateName;

    public Integer getCateId() {
        return cateId;
    }

    public void setCateId(Integer cateId) {
        this.cateId = cateId;
    }

    public String getCateName() {
        return cateName;
    }

    public void setCateName(String cateName) {
        this.cateName = cateName == null ? null : cateName.trim();
    }
}