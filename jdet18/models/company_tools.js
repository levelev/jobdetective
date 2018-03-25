'use strict';

module.exports = (sequelize, DataTypes) => {
  var Model = sequelize.define('company_tools', {
    'created_at': {
      type: DataTypes.DATE,
    },
    'updated_at': {
      type: DataTypes.DATE,
    },
  }, {
    tableName: 'company_tools',
    underscored: true,
    
    schema: process.env.DATABASE_SCHEMA,
  });

  Model.associate = (models) => {
    Model.belongsTo(models.tools, {
      foreignKey: 'tool_id',
      
      as: '_tool_id',
    });
    
    Model.belongsTo(models.companies, {
      foreignKey: 'company_id',
      
      as: '_company_id',
    });
    
  };

  return Model;
};

