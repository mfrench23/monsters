import React from "react"
import PropTypes from "prop-types"
import HiddenField from "./HiddenField.jsx"
import ManyToManyCheckbox from "./ManyToManyCheckbox.jsx"
import ManyToManyDisplayedField from "./ManyToManyDisplayedField.jsx"

class ManyToManyCell extends React.Component {
  render () {
    var isChecked = ! ( this.props.intersectionRow == undefined );
    var intersectionRowId = ( isChecked ? this.props.intersectionRow.id.toString() : "" );
    return (
      <span>
        <HiddenField identifier={this.props.cellId + "[id]"} val={intersectionRowId} />
        <HiddenField identifier={this.props.cellId + "[" + this.props.foreignKeyName + "]"} val={this.props.intersectedId} />
        <HiddenField identifier={this.props.cellId + "[_destroy]"} val="true" />
        <ManyToManyCheckbox identifier={this.props.cellId + "[_destroy]"} val="false" checked={isChecked} />
        <ManyToManyDisplayedField title={this.props.displayTitle} text={this.props.displayText} />
      </span>
    );
  }
}

ManyToManyCell.propTypes = {
  cellId: PropTypes.string,
  intersectedId: PropTypes.string,
  foreignKeyName: PropTypes.string,
  displayTitle: PropTypes.string,
  displayText: PropTypes.string,
  intersectionRow: PropTypes.object
};
export default ManyToManyCell
