import React from "react"
import PropTypes from "prop-types"
import HiddenField from "./HiddenField.jsx"
import ManyToManyCheckbox from "./ManyToManyCheckbox.jsx"
import ManyToManyDisplayedField from "./ManyToManyDisplayedField.jsx"

class ManyToManyCell extends React.Component {
  render () {
    return (
      <span>
        <HiddenField identifier={this.props.cellId + "[id]"} val={this.props.intersection_row_id} />
        <HiddenField identifier={this.props.cellId + "[" + this.props.foreignKeyName + "]"} val={this.props.intersectedId} />
        <HiddenField identifier={this.props.cellId + "[_destroy]"} val="true" />
        <ManyToManyCheckbox identifier={this.props.cellId + "[_destroy]"} val="false" checked={this.props.isChecked} />
        <ManyToManyDisplayedField title={this.props.displayTitle} text={this.props.displayText} />
      </span>
    );
  }
}

ManyToManyCell.propTypes = {
  cellId: PropTypes.string,
  intersectionRowId: PropTypes.string,
  intersectedId: PropTypes.string,
  isChecked: PropTypes.bool,
  foreignKeyName: PropTypes.string,
  displayTitle: PropTypes.string,
  displayText: PropTypes.string
};
export default ManyToManyCell
