'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('leads', {
    'status': {
      type: DataTypes.STRING,
    },
    'notes': {
      type: DataTypes.STRING,
    },
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
  }, {
    tableName: 'leads',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
    Model.belongsTo(models.users, {
      foreignKey: 'user_id',
      
      as: '_user_id',
    });
    
    Model.belongsTo(models.users, {
      foreignKey: 'person_id',
      
      as: '_person_id',
    });
    
  };

  return Model;
};

