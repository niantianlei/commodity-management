package com.nian.bean;

import javax.validation.constraints.Pattern;

public class Products {
    private Integer proId;
    @Pattern(regexp="(^[a-zA-Z0-9_-]{3,16}$)|(^[\u2E80-\u9FFF]+)"
    		,message="用户名必须是中文开头或者3-16位英文和数字的组合")
    private String proName;

    private String proState;
    @Pattern(regexp="^[a-zA-Z0-9]{6,10}",
    		message="货号不正确")
    private String proNo;

    private String proPrice;

    private String proNumber;

    private Integer dId;
    
    private Category category;

    
    
    public Products() {
		super();
		// TODO Auto-generated constructor stub
	}


	public Products(Integer proId, String proName, String proState, String proNo, String proPrice, String proNumber,
			Integer dId) {
		super();
		this.proId = proId;
		this.proName = proName;
		this.proState = proState;
		this.proNo = proNo;
		this.proPrice = proPrice;
		this.proNumber = proNumber;
		this.dId = dId;
	}


	public Category getCategory() {
		return category;
	}

	public void setCategory(Category category) {
		this.category = category;
	}

	public Integer getProId() {
        return proId;
    }

    public void setProId(Integer proId) {
        this.proId = proId;
    }

    public String getProName() {
        return proName;
    }

    public void setProName(String proName) {
        this.proName = proName == null ? null : proName.trim();
    }

    public String getProState() {
        return proState;
    }

    public void setProState(String proState) {
        this.proState = proState == null ? null : proState.trim();
    }

    public String getProNo() {
        return proNo;
    }

    public void setProNo(String proNo) {
        this.proNo = proNo == null ? null : proNo.trim();
    }

    public String getProPrice() {
        return proPrice;
    }

    public void setProPrice(String proPrice) {
        this.proPrice = proPrice == null ? null : proPrice.trim();
    }

    public String getProNumber() {
        return proNumber;
    }

    public void setProNumber(String proNumber) {
        this.proNumber = proNumber == null ? null : proNumber.trim();
    }

    public Integer getdId() {
        return dId;
    }

    public void setdId(Integer dId) {
        this.dId = dId;
    }
}