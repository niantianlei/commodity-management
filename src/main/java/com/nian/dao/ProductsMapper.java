package com.nian.dao;

import com.nian.bean.Products;
import com.nian.bean.ProductsExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface ProductsMapper {
    long countByExample(ProductsExample example);

    int deleteByExample(ProductsExample example);

    int deleteByPrimaryKey(Integer proId);

    int insert(Products record);

    int insertSelective(Products record);

    List<Products> selectByExample(ProductsExample example);

    Products selectByPrimaryKey(Integer proId);

    List<Products> selectByExampleWithCate(ProductsExample example);

    Products selectByPrimaryKeyWithCate(Integer proId);

    int updateByExampleSelective(@Param("record") Products record, @Param("example") ProductsExample example);

    int updateByExample(@Param("record") Products record, @Param("example") ProductsExample example);

    int updateByPrimaryKeySelective(Products record);

    int updateByPrimaryKey(Products record);
}