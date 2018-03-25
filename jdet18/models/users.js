'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('users', {
    'email': {
      type: DataTypes.STRING,
    },
    'encrypted_password': {
      type: DataTypes.STRING,
    },
    'reset_password_token': {
      type: DataTypes.STRING,
    },
    'reset_password_sent_at': {
      type: DataTypes.DATE,
    },
    'remember_created_at': {
      type: DataTypes.DATE,
    },
    'sign_in_count': {
      type: DataTypes.INTEGER,
    },
    'current_sign_in_at': {
      type: DataTypes.DATE,
    },
    'last_sign_in_at': {
      type: DataTypes.DATE,
    },
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
    'provider': {
      type: DataTypes.STRING,
    },
    'uid': {
      type: DataTypes.STRING,
    },
    'first_name': {
      type: DataTypes.STRING,
    },
    'last_name': {
      type: DataTypes.STRING,
    },
    'token': {
      type: DataTypes.STRING,
    },
    'token_expiry': {
      type: DataTypes.DATE,
    },
    'linkedin_pic_url': {
      type: DataTypes.STRING,
    },
    'employment_role': {
      type: DataTypes.STRING,
    },
    'title': {
      type: DataTypes.STRING,
    },
    'seniority': {
      type: DataTypes.STRING,
    },
  }, {
    tableName: 'users',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
    Model.belongsTo(models.companies, {
      foreignKey: 'company_id',
      
      as: '_company_id',
    });
    
  };

  return Model;
};

